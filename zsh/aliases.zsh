# aliases

# System
# toggle WiFi network on/off
# to enter network, `SSID PASS` follows
alias ns="networksetup -setairportpower en0"
# show your network interface name
alias nc="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan"
# clipboard for OS X
alias pc="pbcopy"
alias pp="pbpaste"

# applications
alias o="open -a"
alias chrome="open -a 'google chrome'"
alias starttoday="open -a 'google chrome' | open -a mail | open -a ical | open -a iterm"
alias vi=/usr/local/bin/vim # its for brew vim

# bundler
alias be="bundle exec"
alias bi="bundle install"

# git
# open a remote by browser
alias openremote='git remote show origin | grep Fetch | cut -d ":" -f2 -f3 | cut -d "." -f1 -f2 | xargs python -mwebbrowser'

# ctags
# alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias ctags='`brew --prefix`/bin/ctags'

# Heroku
# open remote app
# alias herokuopen='git remote show heroku | grep {$1} | cut -f4 -d "/" | cut -f1 -d "." | tail -n 1 | xargs heroku open --app'
alias herokuopen='git remote show "{$1}"'

# check my IP address
alias myip='echo "dig +short myip.opendns.com @resolver1.opendns.com"; dig +short myip.opendns.com @resolver1.opendns.com'

# free memory
alias behoimi="sudo purge"
