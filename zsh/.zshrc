# for peco
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  if [ -n "$LBUFFER" ]; then
    BUFFER=$(\history -n 1 | \
      eval $tac | \
      ~/.go/bin/peco --query "$LBUFFER")
  else
    BUFFER=$(\history -n 1 | \
      eval $tac | \
      ~/.go/bin/peco)
  fi
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# zsh theme
# List: ~/.oh-my-zsh/themes/
ZSH_THEME="avit"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# plugins (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh



####################
# my configuration #
####################

# Base Directory Specification
export CONFIG_HOME="$HOME/dotfiles"
export ZSH_CONFIG="$CONFIG_HOME/zsh"

# Import zsh config files
sources+="$ZSH_CONFIG/aliases.zsh"
sources+="$ZSH_CONFIG/exports.zsh"

bindkey '^r' peco-select-history
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
