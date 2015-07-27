# aliases

# applications
alias prv="open -a Preview"
alias starttoday="open -a 'google chrome' | open -a mail | open -a ical | open -a pomodoro\ timer"
alias dic="sdcv"
alias o="open -a"
alias chrome="open -a 'google chrome'"
alias vi=/usr/local/bin/vim # its for brew vim

# bundler
alias be="bundle exec"

# git 
# open a remote by browser
alias openremote='git remote show origin | grep Fetch | cut -d ":" -f2 -f3 | cut -d "." -f1 -f2 | xargs python -mwebbrowser'
