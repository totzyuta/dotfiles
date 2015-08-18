# This script installs libraries.
# 
# It can be run by `$ sh ../bootstrap.sh` 
# and also only it can be if other scripts are unncecessary.

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
