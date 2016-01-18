#!/bin/bash

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# vim by homebrew
brew install vim

# rbenv
brew install rbenv ruby-build

# tmux
brew install tmux reattach-to-user-namespace

# easy jump tool
# source setting script file in .zshrc
brew install autojump

# peco
brew install peco

# ag: the_silver_searcher
brew install ag

# htop
brwe install htop
