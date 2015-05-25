# XDG Base Directory Specification
export CONFIG_HOME="$HOME/.config"
export ZSH_CONFIG="$CONFIG_HOME/zsh"

# executable search path
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/sbin:$PATH

# https://github.com/mxcl/homebrew/issues/11182
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
