# aliases

# applications
alias prv="open -a Preview"
alias starttoday="open -a 'google chrome' | open -a mail | open -a ical | open -a pomodoro\ timer"
alias dic="sdcv"
alias o="open -a"
alias chrome="open -a 'google chrome'"
alias vi=/usr/local/bin/vim # its for brew vim

# git
alias "git log --graph"="git log --graph --branches --pretty=format:'%d [%h] \"%s\""

# bundler
alias be="bundle exec"

# go
export GOROOT=/usr/local/Cellar/go/1.3.3/libexec
export GOPATH=~/.go
export GO_VERSION=1.3.3
export PATH=$GOPATH/bin:$PATH
