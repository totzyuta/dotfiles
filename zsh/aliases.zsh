###############
#   aliases   #
###############

# General
# cd with ls
alias cd="cdls"
# clipboard for macOS
alias pc="pbcopy"
alias pp="pbpaste"

# System
# toggle WiFi network on/off
alias ns="networksetup -setairportpower en0"
# Restart SystemUIServer
alias killsus="kill -9 $(ps aux | grep 'SystemUIServer' | grep -v 'grep' | awk '{ print $2 }')"

# applications
alias o="open -a"
alias chrome="open -a 'google chrome'"
alias vi=vim
alias v=vim

# check my IP address
alias myip='echo "dig +short myip.opendns.com @resolver1.opendns.com"; dig +short myip.opendns.com @resolver1.opendns.com'

# free memory
alias behoimi="sudo purge"

# How's the weather today in Tokyo?
alias weather="curl -sS wttr.in/Tokyo | head -27"
