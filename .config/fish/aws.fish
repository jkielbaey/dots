# All AWS related aliases, functions, etc...
set -x AWS_ASSUME_ROLE_TTL 4h
set -x AWS_SESSION_TTL 4h
set -x AWS_DEFAULT_REGION eu-west-1

# Enable auto-completion aws cli.
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

abbr -a aws_account_id "aws sts get-caller-identity | jq -r .Account"
abbr -a who aws sts get-caller-identity
