#!/bin/bash

do_upgrade=0
while [ $# -ge 1 ]; do
    key="$1"
    case $key in
        -u|--upgrade)
            do_upgrade=1
            echo "-- Doing upgrades.\n"
            ;;
    esac
    shift
done

OS=`uname`
if [ "$OS" == "Darwin" ]; then
    echo "Bootstrapping on MAC OS X...\n"

    BASEDIR=`pwd`/`dirname $0`
    echo "-- Git repo cloned into $BASEDIR.\n"

    if [ ! -f /opt/homebrew/bin/brew ]; then
        echo "Brew is not installed. Let's install that first."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo ""
    fi

    export PATH=$PATH:/opt/homebrew/bin

    echo "# Updating brew and pouring some packages..."
    brew update

    # Tools 
    brew tap neovim/neovim
    brew tap homebrew/cask-versions
    brew tap homebrew/cask
    brew tap homebrew/cask-fonts

    # System tools
    brew install bandwhich bat bottom dos2unix dust exa fd gnu-sed gnu-tar csvkit fish git glances graphviz \
        grex httpie jq neovim powerline-go ripgrep trash watch wget yq yt-dlp
    brew cask install alfred alt-tab font-fira-code font-fira-mono-nerd-font iterm2 keepingyouawake logseq \
        maccy macdown microsoft-teams spectacle spotify visual-studio-code zoom

    # Languages
    brew install go \
        node@14 node@16 yarn \
        python3 \
        ruby brew-gem

    # AWS
    brew tap aws/tap
    brew install aws-cdk aws-nuke aws-sam-cli awscli awscurl cfn-lint rain
    brew gem install cfn-nag

    [ $do_upgrade -eq 1 ] && brew upgrade
    brew cleanup -s
    echo ""
    if ! grep -q '/usr/local/bin/fish' /etc/shells; then
        echo "# Allow use of fish as shell"
        echo '/opt/homebrew/bin/fish' | sudo tee -a /etc/shells >/dev/null 2>&1
        echo ""
    fi

    echo "# Installing/upgrading python packages..."
    pip3 install --upgrade pip pip-tools virtualenv
    echo ""

    echo "# Install powerline fonts..."
    if [ -d $BASEDIR/powerline -a $do_upgrade -eq 1 ]; then
        cd $BASEDIR/powerline
        git pull
        cd $OLDPWD
        sh $BASEDIR/powerline/install.sh
    elif [ ! -d $BASEDIR/powerline ]; then
        git clone https://github.com/powerline/fonts.git --depth=1 $BASEDIR/powerline
        sh $BASEDIR/powerline/install.sh
    fi
    echo ""

elif [ "$OS" == "Linux" ]; then
    echo "Bootstrapping on Linux... no longer supported."
    exit 1
fi
