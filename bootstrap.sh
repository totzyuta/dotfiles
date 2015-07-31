echo ">>> Linking dotfiles with home directory..."
# Take your hats off to the past, but take your coats off to the future.
# mv ~/.vimrc ~/.vimrc.org
# mv ~/.xvimrc ~/.xvimrc.org
# mv ~/.zshrc ~/.zshrc.org
# mv ~/.tmux.conf ~/.tmux.conf.org
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
# use same vimrc for xcode
ln -sf ~/dotfiles/.vimrc ~/.xvimrc
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Git Aliases
echo ">>> Setting git aliases..."
./git_globalconfig

# Install neobundle
echo ">>> Installing neobundle..."
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh 

# Install oh-my-zsh
echo ">>> Installing oh-my-zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh 

# Install go
echo ">>> Installing golang..."
brew install go

# Install peco
echo ">>> Installing peco..."
go get github.com/lestrrat/peco/cmd/peco/

echo "\n"
echo "##############################"
echo "#   Rock On! Happy Coding!   #"
echo "##############################"
