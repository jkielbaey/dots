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

    brew tap homebrew/cask-fonts
    brew tap aws/tap
    brew install dos2unix fish git git-flow glances gnu-tar jq the_silver_searcher \
        alfred appcleaner firefox google-chrome java iterm2 spectacle font-fira-code \
        arping curl htop httpie ipcalc tcping tcptraceroute trash tree watch wget go \
        dep node pyenv pipenv python3 aws-sam-cli awscli aws-vault

    [ $do_upgrade -eq 1 ] && brew upgrade
    brew cleanup
    echo ""

    if ! grep -q '/opt/homebrew/bin/fish' /etc/shells; then
        echo "# Allow use of fish as shell"
        echo '/opt/homebrew/bin/fish' | sudo tee -a /etc/shells >/dev/null 2>&1
        echo ""
    fi

    echo "# Installing powerline-go..."
    if [ ! -f /usr/local/bin/powerline-go -o $do_upgrade -eq 1 ]; then
        POWERLINE_GO_VERSION=v1.12.0
        URL="https://github.com/justjanne/powerline-go/releases/download/${POWERLINE_GO_VERSION}/powerline-go-darwin-amd64"
        curl -L -o /var/tmp/powerline-go $URL
        chmod +x /var/tmp/powerline-go
        mv /var/tmp/powerline-go /usr/local/bin
    fi


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

    # echo "# Create .config symlink."
    # for i in .gitignore .config .vimrc; do
    #     if [ -e ~/${i} ]; then
    #         echo "-- $i"
    #         if [ -e ~/${i}_before_bootstrap ]; then
    #             rm -r ~/${i}
    #         else
    #             mv ~/${i} ~/${i}_before_bootstrap
    #         fi
    #     fi
    #     ln -s $BASEDIR/${i} ~/${i}
    # done

elif [ "$OS" == "Linux" ]; then
    echo "Bootstrapping on Linux... no longer supported."
    exit 1
fi
