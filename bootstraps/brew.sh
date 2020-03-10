#!/bin/bash

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install go
echo ">>> Installing golang..."
brew install go

# vim by homebrew
brew install vim

# rbenv
brew install rbenv ruby-build

# tmux
brew install tmux reattach-to-user-namespace

# easy jump tool
# source setting script file in .zshrc
brew install autojump

# ag: the_silver_searcher
brew install ag

# htop
brwe install htop

# fortune: displays a pseudorandom
brew install fortune

# nvm
brew install nvm

# rmtrash
brew install rmtrash

# peco
brew install peco
