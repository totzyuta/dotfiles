#!/bin/bash
# Install Homebrew and the formulae this dotfiles repo expects.
set -e

if ! command -v brew >/dev/null 2>&1; then
  echo ">>> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo ">>> Updating Homebrew..."
brew update
brew upgrade

echo ">>> Installing formulae..."
brew install vim tmux fzf zoxide
