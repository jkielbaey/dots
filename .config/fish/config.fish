set fish_path $HOME/.config/fish
set fish_greeting

 # Set favourite editor and pager
set -g -x VISUAL vim
set -g -x EDITOR vim
set -g -x PAGER less

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -g -x PYTHON_VERSION (python --version 2>&1)

if echo $PYTHON_VERSION | grep -q 2.6
    set -g -x PYTHONPATH "/usr/lib/python2.6/site-packages"
else if echo $PYTHON_VERSION | grep -q 2.7
    set -g -x PYTHONPATH "/usr/local/lib/python2.7/site-packages"
else if echo $PYTHON_VERSION | grep -q 3.5
    set -g -x PYTHONPATH "/usr/local/lib/python3.5/site-packages"
end

# respect local bins
set -x PATH "./bin" $PATH

# grep colors
setenv -x GREP_OPTIONS "--color=auto"

# Import aliases
. $fish_path/aliases.fish

# SSH Agent
# http://www.maxbucknell.com/blog/2015/5/5/ssh-identities
#
# Start SSH Agent if it's not already running, and add the
# id_(hostname) identity.
setenv SSH_ENV "$HOME/.ssh/environment"
if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end

# Enable powerline
set fish_function_path $fish_function_path "$PYTHONPATH/powerline/bindings/fish"
powerline-setup
