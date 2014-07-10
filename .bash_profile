export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin

# aliases
alias sfr="open -a Safari"
alias prv="open -a Preview"
alias starttoday="open -a Omnifocus | open -a mail | open -a icompta | open -a ical | open -a pomodoro\ timer"
alias dic="open -a dictionary"
alias atom="open -a atom"
alias o="open -a"

alias ls="ls -G"

# history
HISTSIZE=100000
HISTTIMEFORMAT='%F %T '

# Titanium Mobile
# alias titanium='/Library/Application\ Support/Titanium/mobilesdk/osx/1.4.2/titanium.py'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source ~/.profile

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
