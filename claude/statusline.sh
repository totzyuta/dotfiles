#!/bin/bash
# Claude Code custom statusline
# 1行目: model | worktree/dir | git branch + staged/modified (色分け)
# 2行目: context使用率バー(色分け) | cost | duration

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
WORKTREE=$(echo "$input" | jq -r '.workspace.git_worktree // empty')
SESSION_ID=$(echo "$input" | jq -r '.session_id // "nosession"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
SESSION_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' | cut -d. -f1)
WEEK_PCT=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' | cut -d. -f1)

DNAME=$(basename "$DIR" 2>/dev/null)

# --- colors ---
RESET='\033[0m'
DIM='\033[2m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
CYAN='\033[36m'
MAGENTA='\033[35m'

# --- git info (cached 5s, per-session cache file) ---
CACHE_FILE="/tmp/statusline-git-cache-$SESSION_ID"
CACHE_MAX_AGE=5

cache_is_stale() {
    [ ! -f "$CACHE_FILE" ] || \
    [ $(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0))) -gt $CACHE_MAX_AGE ]
}

if cache_is_stale; then
    if git rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH=$(git branch --show-current 2>/dev/null)
        STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
        MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
        UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
        echo "$BRANCH|$STAGED|$MODIFIED|$UNTRACKED" > "$CACHE_FILE"
    else
        echo "||||" > "$CACHE_FILE"
    fi
fi
IFS='|' read -r BRANCH STAGED MODIFIED UNTRACKED < "$CACHE_FILE"

# --- line 1: model | worktree/dir | branch+status ---
LOCATION="$DNAME"
if [ -n "$WORKTREE" ]; then
    LOCATION="🌳 $WORKTREE"
fi

GITPART=""
if [ -n "$BRANCH" ]; then
    if [ "${STAGED:-0}" = "0" ] && [ "${MODIFIED:-0}" = "0" ] && [ "${UNTRACKED:-0}" = "0" ]; then
        GITPART="${DIM}${GREEN}$BRANCH ✓${RESET}"
    else
        GITPART="${DIM}${YELLOW}$BRANCH${RESET}"
        [ "${STAGED:-0}" != "0" ] && GITPART="$GITPART ${GREEN}+${STAGED}${RESET}"
        [ "${MODIFIED:-0}" != "0" ] && GITPART="$GITPART ${YELLOW}~${MODIFIED}${RESET}"
        [ "${UNTRACKED:-0}" != "0" ] && GITPART="$GITPART ${DIM}?${UNTRACKED}${RESET}"
    fi
fi

LINE1="${DIM}${MODEL}${RESET} ${DIM}|${RESET} ${CYAN}${LOCATION}${RESET}"
[ -n "$GITPART" ] && LINE1="$LINE1 ${DIM}|${RESET} $GITPART"

# --- line 2: context bar | cost | duration ---
BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
[ "$FILLED" -gt "$BAR_WIDTH" ] && FILLED=$BAR_WIDTH
EMPTY=$((BAR_WIDTH - FILLED))

if [ "$PCT" -ge 80 ]; then
    BARCOLOR=$RED
elif [ "$PCT" -ge 50 ]; then
    BARCOLOR=$YELLOW
else
    BARCOLOR=$GREEN
fi

BAR=""
for ((i=0; i<FILLED; i++)); do BAR="${BAR}▓"; done
for ((i=0; i<EMPTY; i++)); do BAR="${BAR}░"; done

COST_FMT=$(printf '%.2f' "$COST" 2>/dev/null || echo "$COST")
DURATION_S=$((DURATION_MS / 1000))
DURATION_M=$((DURATION_S / 60))
DURATION_S_REM=$((DURATION_S % 60))

LINE2="${BARCOLOR}${BAR}${RESET} ${PCT}% ${DIM}|${RESET} ${MAGENTA}\$${COST_FMT}${RESET} ${DIM}|${RESET} ${DIM}${DURATION_M}m${DURATION_S_REM}s${RESET}"

if [ -n "$SESSION_PCT" ]; then
    if [ "$SESSION_PCT" -ge 80 ]; then
        SESSCOLOR=$RED
    elif [ "$SESSION_PCT" -ge 50 ]; then
        SESSCOLOR=$YELLOW
    else
        SESSCOLOR=$GREEN
    fi
    LINE2="$LINE2 ${DIM}|${RESET} session ${SESSCOLOR}${SESSION_PCT}%${RESET}"
fi

if [ -n "$WEEK_PCT" ]; then
    if [ "$WEEK_PCT" -ge 80 ]; then
        WEEKCOLOR=$RED
    elif [ "$WEEK_PCT" -ge 50 ]; then
        WEEKCOLOR=$YELLOW
    else
        WEEKCOLOR=$GREEN
    fi
    LINE2="$LINE2 ${DIM}|${RESET} week ${WEEKCOLOR}${WEEK_PCT}%${RESET}"
fi

printf '%b\n%b' "$LINE1" "$LINE2"
