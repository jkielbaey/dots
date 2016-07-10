set fish_path $HOME/.config/fish
set fish_greeting

 # Set favourite editor and pager
set -g -x VISUAL vim
set -g -x EDITOR vim
set -g -x PAGER less

. $fish_path/aliases.fish
. $fish_path/export.fish

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
set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish"
powerline-setup
