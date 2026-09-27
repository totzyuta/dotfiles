export EDITOR='vim'

# Homebrew (Apple Silicon)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$HOME/bin:$PATH"

# aws cli
export PATH="$HOME/.local/bin:$PATH"
