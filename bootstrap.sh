#!/bin/bash
#
# Sets up a new machine from this dotfiles repo. Safe to re-run.
#
set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sh "$DOTFILES_DIR/bootstraps/brew.sh"
sh "$DOTFILES_DIR/bootstraps/fetch.sh"
sh "$DOTFILES_DIR/bootstraps/link.sh"

echo ""
echo "##############################"
echo "#   Rock On! Happy Coding!   #"
echo "##############################"
