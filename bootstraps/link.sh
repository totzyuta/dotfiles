# This script links all dotfiles and git global configs
#
# It can be run by `$ sh ../bootstrap.sh`
# and also only it can be if other scripts are unncecessary.

echo ">>> Linking dotfiles with home directory..."
# Take your hats off to the past, but take your coats off to the future.
mv ~/.vimrc ~/.vimrc.org
mv ~/.xvimrc ~/.xvimrc.org
mv ~/.zshrc ~/.zshrc.org
mv ~/.tmux.conf ~/.tmux.conf.org

# link new dotfiles
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/xvimrc ~/.xvimrc
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh ~/.zsh
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.pryrc ~/.pryrc

# Git Aliases
echo ">>> Setting git aliases..."
./git_globalconfig
