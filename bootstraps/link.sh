#!/bin/bash
# Links this repo's dotfiles into the home directory. Safe to re-run.
#
# Anything it would overwrite is backed up first under
# ~/.dotfiles-backups/<timestamp>/ instead of just being clobbered.
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_and_remove() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    cp -a "$target" "$BACKUP_DIR/" 2>/dev/null || true
    rm -rf "$target"
  fi
}

echo ">>> Linking dotfiles into $HOME (backups -> $BACKUP_DIR if anything is replaced)..."

# vim
backup_and_remove ~/.vimrc
ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc

# tmux
backup_and_remove ~/.tmux.conf
ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf

# zsh: the real ~/.zshrc stays owned by oh-my-zsh (theme/plugins/etc). We
# only symlink our extras file and make sure ~/.zshrc sources it once.
backup_and_remove ~/.zshrc.local
ln -sf "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc.local

SOURCE_LINE='[ -f ~/.zshrc.local ] && source ~/.zshrc.local'
if [ -f ~/.zshrc ] && ! grep -qF "$SOURCE_LINE" ~/.zshrc; then
  cp -a ~/.zshrc "$BACKUP_DIR/.zshrc"
  printf '\n# dotfiles extras\n%s\n' "$SOURCE_LINE" >> ~/.zshrc
fi

# Claude Code
mkdir -p ~/.claude
backup_and_remove ~/.claude/statusline.sh
ln -sf "$DOTFILES_DIR/claude/statusline.sh" ~/.claude/statusline.sh

echo ">>> Setting git aliases..."
(cd "$DOTFILES_DIR" && ./git_globalconfig)
