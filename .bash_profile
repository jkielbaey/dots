# .bash_profile

# Determine OS
# (Darwin: Mac // Linux: Linux)
OS=`uname`
if [ "$OS" != 'Darwin' -a "$OS" != 'Linux' ]; then
	echo "Note: script used on unknown OS type."
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export VISUAL=vim
export EDITOR=vim

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin

# Add go lang to PATH and set GOPATH.
if [ -f /usr/local/go ]; then
	export PATH=$PATH:/usr/local/go/bin
	export GOPATH=$HOME/go
	[ ! -d $GOPATH ] && mkdir $GOPATH
fi

# Enable bash completion on MAC.
if [ "$OS" == 'Darwin' ]; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		source $(brew --prefix)/etc/bash_completion
	fi

    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
fi

# GIT STUFF
# git command autocompletion script
if [ -f /etc/bash_completion.d/git ]; then
	source /etc/bash_completion.d/git
fi

# git commands simplified
alias gst='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gpl='git pull'
alias gp='git push'
alias gad='git add .'
alias gcm='git checkout master'
alias gm='git merge --no-commit --log'
alias gcob="git checkout -b"
alias gco="git checkout"
alias gl="git log"
alias glp="git log --pretty=format:'%h - %an, %ar : %s'"

# turn on coloring on grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls alias for color-mode
if [ "$OS" == 'Darwin' ]; then
	alias ls='ls -lhaG'
elif [ "$OS" == 'Linux' ]; then
	alias ls='ls -lha --color=always'
fi
alias l='ls -CF'
alias la='ls -la'
alias ll='ls -hlF'

# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

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
if [ -d /opt/rh/git19 ]; then
	source scl_source enable git19
fi

# Enable ruby 1.9.3 by default
if [ -d /opt/rh/ruby193 ]; then
	source scl_source enable ruby193
fi

# Enable python 2.7 by default
if [ -d /opt/rh/python27 ]; then
	source scl_source enable python27
fi

export PYTHON_VERSION=`python --version 2>&1`

if [ "$OS" == 'Darwin' ]; then
	if echo $PYTHON_VERSION | grep -q 2.7; then
		export PYTHONPATH='/Library/Python/2.7/site-packages'
	fi
elif [ "$OS" == 'Linux' ]; then
	if [ -d /usr/lib/python2.6/site-packages ]; then
		export PYTHONPATH=/usr/lib/python2.6/site-packages
	fi
	if echo $PYTHON_VERSION | grep -q 2.7; then
		# Assuming python 2.7 installed via SCL
		export PYTHONPATH=/opt/rh/python27/root/usr/lib/python2.7/site-packages
	fi
	if echo $PYTHON_VERSION | grep -q 3.3; then
		# Assuming python 2.7 installed via SCL
		export PYTHONPATH=/opt/rh/python33/root/usr/lib/python3.3/site-packages
	fi
fi

# Powerline
if [ -f /usr/bin/powerline-daemon ]; then
	/usr/bin/powerline-daemon -q
elif [ -f /usr/bin/powerline-daemon ]; then
	/usr/local/bin/powerline-daemon -q
fi
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source $PYTHONPATH/powerline/bindings/bash/powerline.sh

#source /usr/lib/python2.6/site-packages/powerline/bindings/bash/powerline.sh

alias history="history | nl | less +G"

alias weather="curl -4 wttr.in/Geraardsbergen"
alias moon="curl -4 wttr.in/Moon"

alias https='http --default-scheme=https'
