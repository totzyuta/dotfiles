###############
#   aliases   #
###############

# General
# cd with ls
alias cd="cdls"
# clipboard for OS X
alias pc="pbcopy"
alias pp="pbpaste"

# System
# toggle WiFi network on/off
# to enter network, `SSID PASS` follows
alias ns="networksetup -setairportpower en0"
# show your network interface name
alias nc="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan"

# applications
alias o="open -a"
alias chrome="open -a 'google chrome'"
alias workspace="open -a 'google chrome' https://onebox.esa.io | open -a 'google chrome' https://messenger.com | open -a 'google chrome' https://github.com/totzyuta | open -a mail | open -a ical | open -a slack | open -a terminal"
alias vi=/usr/local/bin/vim # brewed vim
alias v=/usr/local/bin/vim # brewed vim

# bundler
alias be="bundle exec"
alias bi="bundle install"

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
