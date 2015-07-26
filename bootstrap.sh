echo ">>> Linking dotfiles with home directory..."
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
mv ~/.zshrc ~/.zshrc.org
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.xvimrc ~/.xvimrc
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
