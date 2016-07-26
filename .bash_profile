# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$PATH:$HOME/bin

# GIT STUFF

# git command autocompletion script
source /etc/bash_completion.d/git

# git commamands simplified
alias gst='git status'
alias gco='git checkout'
alias gci='git commit'
alias gpl='git pull'
alias gpu='git push'
alias gad='git add .'
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias gcm='git checkout master'
alias gmg='git merge --no-commit --log'

# ls alias for color-mode
alias ls='ls -lha --color=always'

# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Show clean/dirty state for Git in prompt
export GIT_PS1_SHOWDIRTYSTATE=1

# Change prompt
if [ "`id -u`" != "0" ]; then
    PS1_OLD=${PS1}
    export PS1='\[\033[1;33m\]\h\[\033[0m\] \[\033[1;36m\]\u\[\033[0m\]:\[\033[1;36m\]\w\[\033[0m\] \[\033[1;92m\]$(__git_ps1 "(%s)")\[\033[0m\]$ '
fi

# Ensure all rubies and gemsets are stored in the homedir of the user.
#rvm user all

# Configure SSH agent.
SSH_ENVDIR="$HOME/.ssh"
SSH_ENV="$SSH_ENVDIR/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -d "${SSH_ENVDIR}" ]; then
  if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
      start_agent;
    }
  else
    start_agent;
  fi
fi

# Enable git1.9 by default
source scl_source enable git19

# Enable ruby 1.9.3 by default
source scl_source enable ruby193
