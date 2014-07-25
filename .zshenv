# profiliing
#zmodload zsh/zprof && zprof

export EDITOR='vim'

# aliases
alias sfr="open -a Safari"
alias prv="open -a Preview"
alias starttoday="open -a Omnifocus | open -a mail | open -a icompta | open -a ical | open -a pomodoro\ timer"
alias dic="sdcv"
alias atom="open -a atom"
alias o="open -a"
alias chrome="open -a 'google chrome'"

# go
export GOROOT=/usr/local/Cellar/go/1.3/libexec
export GOPATH=~/.go
export GO_VERSION=1.3
export PATH=$GOPATH/bin:$PATH
