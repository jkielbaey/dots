# All AWS related aliases, functions, etc...

set -x AWS_ASSUME_ROLE_TTL 2h
set -x AWS_SESSION_TTL 2h
set -x AWS_DEFAULT_REGION eu-west-1

# Enable auto-completion aws cli.
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
