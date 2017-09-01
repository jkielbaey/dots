set fish_path $HOME/.config/fish
set fish_greeting

 # Set favourite editor and pager
set -g -x VISUAL nvim
set -g -x EDITOR nvim
set -g -x PAGER less

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# respect local bins
set -x PATH "/usr/local/opt/python/libexec/bin" $PATH
set -x PATH "./bin" $PATH

# Import aliases
. $fish_path/aliases.fish

# Enable powerline
set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish"
powerline-setup

# Start SSH Agent and set relevant variables
function start_agent
  echo "Initializing new SSH agent ..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "succeeded"
  chmod 600 $SSH_ENV
  . $SSH_ENV > /dev/null
end

# Ensure ssh-agent is running.
setenv SSH_ENV "$HOME/.ssh/environment"
if [ -n "$SSH_AGENT_PID" ]
  ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
  if [ $status -ne 0 ]
    start_agent
  end
else
  if [ -f $SSH_ENV ]
    . $SSH_ENV >/dev/null
  end
  ps -ef | grep ssh-agent | grep -v grep > /dev/null
  if [ $status -ne 0 ]
    start_agent
  end
end

# Load ssh keys.
/bin/ls $HOME/.ssh/id_rsa* | grep -v .pub | while read f
  ssh-add -l | grep $f >/dev/null
  if [ $status -ne 0 ]
    echo Loading $f
    ssh-add $f
  end
end

complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
set -g fish_user_paths "/usr/local/bin" $fish_user_paths

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

eval (python -m virtualfish)
