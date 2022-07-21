set fish_path $HOME/.config/fish
set fish_greeting

# Set favourite editor and pager
set -g -x VISUAL nvim
set -g -x EDITOR nvim
set -g -x PAGER less

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x GOPATH $HOME/go_workspace

# respect local bins
set -x PATH "$HOME/bin" "$GOPATH/bin" /usr/local/opt/gnu-tar/libexec/gnubin/ /usr/local/opt/python/libexec/bin $PATH
set -g fish_user_paths /usr/local/bin /usr/local/sbin $fish_user_paths

# Import aliases
. $fish_path/aliases.fish

function fish_prompt
    powerline-go -error $status -modules aws,git,cwd,newline,time -cwd-mode plain
end

## curl
set -g fish_user_paths /usr/local/opt/curl/bin $fish_user_paths
set -gx LDFLAGS -L/usr/local/opt/curl/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/curl/include $CPPFLAGS
set -gx PKG_CONFIG_PATH /usr/local/opt/curl/lib/pkgconfig $PKG_CONFIG_PATH

## readline
set -g fish_user_paths /usr/local/opt/curl/bin $fish_user_paths
set -gx LDFLAGS -L/usr/local/opt/readline/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/readline/include $CPPFLAGS
set -gx PKG_CONFIG_PATH /usr/local/opt/curl/lib/pkgconfig $PKG_CONFIG_PATH

## gettext
set -gx LDFLAGS -L/usr/local/opt/gettext/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/gettext/include $CPPFLAGS
set -x PATH /usr/local/opt/gettext/bin $PATH

## ncurses
set -g fish_user_paths /usr/local/opt/ncurses/bin $fish_user_paths
set -gx LDFLAGS -L/usr/local/opt/ncurses/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/ncurses/include $CPPFLAGS
set -gx PKG_CONFIG_PATH /usr/local/opt/ncurses/lib/pkgconfig $PKG_CONFIG_PATH

## gnu-tar
set -g fish_user_paths /usr/local/opt/gnu-tar/libexec/gnubin $fish_user_paths

## openssl
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib" $LDFLAGS
set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include" $CPPFLAGS
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig" $PKG_CONFIG_PATH

## icu4c
set -g fish_user_paths /usr/local/opt/icu4c/bin $fish_user_paths
set -g fish_user_paths /usr/local/opt/icu4c/sbin $fish_user_paths
set -gx LDFLAGS -L/usr/local/opt/icu4c/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/icu4c/include $CPPFLAGS
set -gx PKG_CONFIG_PATH /usr/local/opt/icu4c/lib/pkgconfig $PKG_CONFIG_PATH

## sqlite
set -g fish_user_paths /usr/local/opt/sqlite/bin $fish_user_paths
set -gx LDFLAGS -L/usr/local/opt/sqlite/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/sqlite/include $CPPFLAGS
set -gx PKG_CONFIG_PATH /usr/local/opt/sqlite/lib/pkgconfig $PKG_CONFIG_PATH

## zlib
set -gx LDFLAGS -L/usr/local/opt/zlib/lib $LDFLAGS
set -gx CPPFLAGS -I/usr/local/opt/zlib/include $CPPFLAGS
set -gx PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig $PKG_CONFIG_PATH

# Initialize ssh-agent
. $fish_path/ssh-agent.fish

# Add aws-vault aliases and functions
. $fish_path/aws.fish

set -x PATH "$HOME/anaconda3/bin" $PATH
