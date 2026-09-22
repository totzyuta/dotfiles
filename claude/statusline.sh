#!/bin/bash
# Claude Code custom statusline — Catppuccin Frappé, single line, no icons.
# model(effort) | worktree/dir | branch+status | PR #N +add/-del | context bar % |
# tokens in/out | cost | duration | cache hit% | session(5h)% | week(7d)%
#
# PR diff uses `gh pr diff` (network call, cached 30s) — falls back to hiding
# the +add/-del segment if `gh` is unavailable or the call fails.

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
WORKTREE=$(echo "$input" | jq -r '.workspace.git_worktree // empty')
SESSION_ID=$(echo "$input" | jq -r '.session_id // "nosession"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
IN_TOK=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
OUT_TOK=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
CACHE_HIT=$(echo "$input" | jq -r '.prompt_cache.hit_ratio // empty')
SESSION_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' | cut -d. -f1)
WEEK_PCT=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' | cut -d. -f1)
PR_NUM=$(echo "$input" | jq -r '.pr.number // empty')
REPO_OWNER=$(echo "$input" | jq -r '.workspace.repo.owner // empty')
REPO_NAME=$(echo "$input" | jq -r '.workspace.repo.name // empty')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

DNAME=$(basename "$DIR" 2>/dev/null)

# --- Catppuccin Frappé (24-bit truecolor) ---
RESET='\033[0m'
LAVENDER='\033[38;2;186;187;241m'   # model
TEAL='\033[38;2;129;200;190m'       # dir / worktree
MAUVE='\033[38;2;202;158;230m'      # branch (clean)
YELLOW='\033[38;2;229;200;144m'     # branch (dirty) / semantic warn
GREEN='\033[38;2;166;209;137m'      # staged / diff add / semantic good
PEACH='\033[38;2;239;159;118m'      # modified count
RED='\033[38;2;231;130;132m'        # diff remove / semantic critical
BLUE='\033[38;2;140;170;238m'       # PR number
SAPPHIRE='\033[38;2;133;193;220m'   # cost amount
OVERLAY='\033[38;2;115;121;148m'    # separators / dim
SUBTEXT='\033[38;2;165;173;206m'    # secondary text

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

# --- PR diff stat (via gh, cached 30s to limit API calls) ---
PR_DIFF_PART=""
if [ -n "$PR_NUM" ] && [ -n "$REPO_OWNER" ] && [ -n "$REPO_NAME" ] && command -v gh >/dev/null 2>&1; then
    PR_CACHE_FILE="/tmp/statusline-prdiff-cache-$SESSION_ID-$PR_NUM"
    PR_CACHE_MAX_AGE=30

    pr_cache_is_stale() {
        [ ! -f "$PR_CACHE_FILE" ] || \
        [ $(($(date +%s) - $(stat -f %m "$PR_CACHE_FILE" 2>/dev/null || stat -c %Y "$PR_CACHE_FILE" 2>/dev/null || echo 0))) -gt $PR_CACHE_MAX_AGE ]
    }

    if pr_cache_is_stale; then
        DIFF_TEXT=$(gh pr diff "$PR_NUM" --repo "$REPO_OWNER/$REPO_NAME" 2>/dev/null)
        if [ -n "$DIFF_TEXT" ]; then
            PR_ADD=$(echo "$DIFF_TEXT" | grep -c '^+' 2>/dev/null)
            PR_ADD_HDR=$(echo "$DIFF_TEXT" | grep -c '^+++' 2>/dev/null)
            PR_DEL=$(echo "$DIFF_TEXT" | grep -c '^-' 2>/dev/null)
            PR_DEL_HDR=$(echo "$DIFF_TEXT" | grep -c '^---' 2>/dev/null)
            PR_ADD=$((PR_ADD - PR_ADD_HDR))
            PR_DEL=$((PR_DEL - PR_DEL_HDR))
            echo "$PR_ADD|$PR_DEL" > "$PR_CACHE_FILE"
        else
            echo "|" > "$PR_CACHE_FILE"
        fi
    fi
    IFS='|' read -r PR_ADD PR_DEL < "$PR_CACHE_FILE"
    if [ -n "$PR_ADD" ] && [ -n "$PR_DEL" ]; then
        PR_DIFF_PART="${GREEN}+${PR_ADD}${RESET}${OVERLAY}/${RESET}${RED}-${PR_DEL}${RESET}"
    fi
fi

# --- location: worktree name takes priority over dir name ---
LOCATION="$DNAME"
[ -n "$WORKTREE" ] && LOCATION="$WORKTREE"

# --- branch + dirty status (no icons, color communicates state) ---
GITPART=""
if [ -n "$BRANCH" ]; then
    if [ "${STAGED:-0}" = "0" ] && [ "${MODIFIED:-0}" = "0" ] && [ "${UNTRACKED:-0}" = "0" ]; then
        GITPART="${MAUVE}${BRANCH}${RESET}"
    else
        GITPART="${YELLOW}${BRANCH}${RESET}"
        [ "${STAGED:-0}" != "0" ] && GITPART="$GITPART ${GREEN}+${STAGED}${RESET}"
        [ "${MODIFIED:-0}" != "0" ] && GITPART="$GITPART ${PEACH}~${MODIFIED}${RESET}"
        [ "${UNTRACKED:-0}" != "0" ] && GITPART="$GITPART ${OVERLAY}?${UNTRACKED}${RESET}"
    fi
fi

# --- context bar (10 blocks, Catppuccin-style fill) ---
BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
[ "$FILLED" -gt "$BAR_WIDTH" ] && FILLED=$BAR_WIDTH
EMPTY=$((BAR_WIDTH - FILLED))

if [ "$PCT" -ge 80 ]; then BARCOLOR=$RED
elif [ "$PCT" -ge 50 ]; then BARCOLOR=$YELLOW
else BARCOLOR=$GREEN
fi

BAR=""
for ((i=0; i<FILLED; i++)); do BAR="${BAR}▓"; done
for ((i=0; i<EMPTY; i++)); do BAR="${BAR}░"; done

COST_FMT=$(printf '%.2f' "$COST" 2>/dev/null || echo "$COST")

fmt_tok() {
    local n=$1
    if [ "$n" -ge 1000000 ]; then
        awk -v n="$n" 'BEGIN{printf "%.1fM", n/1000000}'
    elif [ "$n" -ge 1000 ]; then
        awk -v n="$n" 'BEGIN{printf "%.1fK", n/1000}'
    else
        echo "$n"
    fi
}
IN_TOK_FMT=$(fmt_tok "$IN_TOK")
OUT_TOK_FMT=$(fmt_tok "$OUT_TOK")

CACHE_PCT=""
if [ -n "$CACHE_HIT" ]; then
    CACHE_PCT=$(awk -v h="$CACHE_HIT" 'BEGIN{printf "%d", h*100}')
fi

# --- duration (h/m/s) ---
DURATION_S=$((DURATION_MS / 1000))
DURATION_H=$((DURATION_S / 3600))
DURATION_M=$(((DURATION_S % 3600) / 60))
if [ "$DURATION_H" -gt 0 ]; then
    DURATION_FMT="${DURATION_H}h${DURATION_M}m"
else
    DURATION_FMT="${DURATION_M}m"
fi

LINE="${LAVENDER}${MODEL}${RESET}"
[ -n "$EFFORT" ] && LINE="$LINE ${OVERLAY}(${EFFORT})${RESET}"
LINE="$LINE ${OVERLAY}│${RESET} ${TEAL}${LOCATION}${RESET}"
[ -n "$GITPART" ] && LINE="$LINE ${OVERLAY}│${RESET} $GITPART"
if [ -n "$PR_NUM" ]; then
    LINE="$LINE ${OVERLAY}│${RESET} ${SUBTEXT}PR${RESET} ${BLUE}#${PR_NUM}${RESET}"
    [ -n "$PR_DIFF_PART" ] && LINE="$LINE $PR_DIFF_PART"
fi
LINE="$LINE ${OVERLAY}│${RESET} ${BARCOLOR}${BAR}${RESET} ${SUBTEXT}${PCT}%${RESET}"
LINE="$LINE ${OVERLAY}│${RESET} ${SUBTEXT}↓${IN_TOK_FMT} ↑${OUT_TOK_FMT}${RESET}"
LINE="$LINE ${OVERLAY}│${RESET} ${SAPPHIRE}\$${COST_FMT}${RESET}"
LINE="$LINE ${OVERLAY}│${RESET} ${SUBTEXT}${DURATION_FMT}${RESET}"
if [ -n "$CACHE_PCT" ]; then
    if [ "$CACHE_PCT" -ge 80 ]; then CHC=$GREEN
    elif [ "$CACHE_PCT" -ge 50 ]; then CHC=$YELLOW
    else CHC=$RED
    fi
    LINE="$LINE ${OVERLAY}│${RESET} ${SUBTEXT}cache${RESET} ${CHC}${CACHE_PCT}%${RESET}"
fi

if [ -n "$SESSION_PCT" ]; then
    if [ "$SESSION_PCT" -ge 80 ]; then SC=$RED
    elif [ "$SESSION_PCT" -ge 50 ]; then SC=$YELLOW
    else SC=$GREEN
    fi
    LINE="$LINE ${OVERLAY}│${RESET} ${SUBTEXT}session${RESET} ${SC}${SESSION_PCT}%${RESET}"
fi

if [ -n "$WEEK_PCT" ]; then
    if [ "$WEEK_PCT" -ge 80 ]; then WC=$RED
    elif [ "$WEEK_PCT" -ge 50 ]; then WC=$YELLOW
    else WC=$GREEN
    fi
    LINE="$LINE ${OVERLAY}│${RESET} ${SUBTEXT}week${RESET} ${WC}${WEEK_PCT}%${RESET}"
fi

printf '%b' "$LINE"
