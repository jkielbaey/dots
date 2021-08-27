set fish_path $HOME/.config/fish
set fish_greeting

# Set favourite editor and pager
set -g -x PAGER less

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x GOPATH $HOME/go_workspace
set -x GOROOT $HOME/go

# respect local bins
set -x PATH "$HOME/bin" "$GOROOT/bin" "$GOPATH/bin" "/opt/homebrew/bin" "/usr/local/opt/gnu-tar/libexec/gnubin/" "/usr/local/opt/python/libexec/bin" $PATH
fish_add_path "$HOME/bin" "$GOROOT/bin" "$GOPATH/bin" "/opt/homebrew/bin"

# Import aliases
. $fish_path/aliases.fish

function fish_prompt
    $GOROOT/bin/powerline-go -error $status -shell bare -cwd-max-depth 3 -cwd-max-dir-size 15 -modules time,aws,git,cwd -path-aliases \~/Dropbox/Lightroom/Wolverine=@WOLVERINE -git-mode simple
end

## curl
fish_add_path /opt/homebrew/opt/curl/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/curl/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/curl/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/curl/lib/pkgconfig"

## readline
set -gx LDFLAGS "-L/opt/homebrew/opt/readline/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/readline/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/readline/lib/pkgconfig"

## ncurses
fish_add_path /opt/homebrew/opt/ncurses/bin
#set -g fish_user_paths "/usr/local/opt/ncurses/bin" $fish_user_paths
#set -gx LDFLAGS "-L/usr/local/opt/ncurses/lib" $LDFLAGS
#set -gx CPPFLAGS "-I/usr/local/opt/ncurses/include" $CPPFLAGS
#set -gx PKG_CONFIG_PATH "/usr/local/opt/ncurses/lib/pkgconfig" $PKG_CONFIG_PATH

## gnu-tar
fish_add_path /opt/homebrew/opt/gnu-tar/libexec/gnubin

## openssl
fish_add_path /opt/homebrew/opt/openssl@1.1/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl@1.1/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

## icu4c
fish_add_path /opt/homebrew/opt/icu4c/bin
fish_add_path /opt/homebrew/opt/icu4c/sbin
set -gx LDFLAGS "-L/opt/homebrew/opt/icu4c/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/icu4c/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/icu4c/lib/pkgconfig"

## sqlite
fish_add_path /opt/homebrew/opt/sqlite/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/sqlite/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/sqlite/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/sqlite/lib/pkgconfig"

## zlib
set -gx LDFLAGS "-L/opt/homebrew/opt/zlib/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/zlib/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/zlib/lib/pkgconfig"

# Initialize ssh-agent
. $fish_path/ssh-agent.fish

# Add aws-vault aliases and functions
. $fish_path/aws.fish
