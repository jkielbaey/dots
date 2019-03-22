set fish_path $HOME/.config/fish
set fish_greeting

 # Set favourite editor and pager
set -g -x VISUAL nvim
set -g -x EDITOR nvim
set -g -x PAGER less

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x AWS_DEFAULT_REGION eu-west-1
set -x GOPATH $HOME/go_workspace

# respect local bins
set -x PATH "$HOME/bin" "$GOPATH/bin" "/usr/local/opt/gnu-tar/libexec/gnubin/" "/usr/local/opt/python/libexec/bin" $PATH
set -g fish_user_paths "/usr/local/bin" "/usr/local/sbin" $fish_user_paths

# Import aliases
. $fish_path/aliases.fish

# Enable auto-completion aws cli.
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

function fish_prompt
    /Users/jkielbaey/go_workspace/bin/powerline-go -error $status -shell bare -cwd-max-depth 3 -modules time,venv,aws,terraform-workspace,cwd,gitlite -path-aliases \~/git/anb=+GA
end


## curl
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/curl/lib"
set -gx CPPFLAGS "-I/usr/local/opt/curl/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/curl/lib/pkgconfig"

## ncurses
set -g fish_user_paths "/usr/local/opt/ncurses/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/ncurses/lib"
set -gx CPPFLAGS "-I/usr/local/opt/ncurses/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/ncurses/lib/pkgconfig"

## gnu-tar
set -g fish_user_paths "/usr/local/opt/gnu-tar/libexec/gnubin" $fish_user_paths

## openssl
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"

## icu4c
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/icu4c/lib"
set -gx CPPFLAGS "-I/usr/local/opt/icu4c/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig"

## sqlite
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/sqlite/lib"
set -gx CPPFLAGS "-I/usr/local/opt/sqlite/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/sqlite/lib/pkgconfig"

# Initialize pyenv
. $fish_path/pyenv.fish

# Initialize ssh-agent
. $fish_path/ssh-agent.fish

# Add aws-vault aliases and functions
. $fish_path/aws-vault.fish
