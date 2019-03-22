# Start SSH Agent and set relevant variables
function start_agent
  echo "Initializing new SSH agent ..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  . $SSH_ENV > /dev/null
end

# Load ssh keys
function load_ssh_keys
  /bin/ls $HOME/.ssh/id_rsa* | grep -v .pub | while read f
    ssh-add -l | grep $f >/dev/null
    if [ $status -ne 0 ]
      ssh-add $f
    end
  end
end


# Ensure ssh-agent is running.
setenv SSH_ENV "$HOME/.ssh/environment"
if [ -n "$SSH_AGENT_PID" ]
  ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
  if [ $status -ne 0 ]
    start_agent
    load_ssh_keys
  end
else
  if [ -f $SSH_ENV ]
    . $SSH_ENV >/dev/null
  end
  ps -ef | grep ssh-agent | grep -v grep > /dev/null
  if [ $status -ne 0 ]
    start_agent
    load_ssh_keys
  end
end
