#!/bin/bash

OS=`uname`
if [ "$OS" == "Darwin" ]; then
    echo "Bootstrapping on MAC OS X..."
    if [ ! -f /usr/local/bin/brew ]; then
        echo "Brew is not installed. Let's install that first."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    echo "# Updating brew and pouring some packages..."
    brew update
    brew upgrade
    brew install python --upgrade
    brew install python3 --upgrade
    brew install ruby --upgrade
    brew install perl --upgrade
    brew install git --upgrade
    brew install fish --upgrade
    brew install httpie --upgrade
    brew install vim --with-python --with-ruby --with-perl --upgrade
    brew install macvim --env-std --with-override-system-vim --upgrade
    brew link --overwrite macvim
    brew cleanup

    echo "# Allow use of fish as shell"
    if ! grep -q '/usr/local/bin/fish' /etc/shells; then
        echo '/usr/local/bin/fish' >> /etc/shells
    fi

    echo "# Installing/upgrading python packages..."
    pip install pip --upgrade
    pip install powerline-status --upgrade

    echo "# Install powerline fonts..."
    sh ~/mydots/powerline_fonts/install.sh

    echo "# Create symlinks for .vim, .vimrc and .config"
    for i in .vim .vimrc .config; do
        if [ -e ~/${i} ]; then
            if [ -e ~/${i}_before_bootstrap ]; then
                rm -r ~/${i}
            else
                mv ~/${i} ~/${i}_before_bootstrap
            fi
        fi
        ln -s ~/mydots/${i} .
    done

    echo "# Install VIM plugins..."
    vim +PluginInstall +qall

elif [ "$OS" == "Linux" ]; then
    echo "Bootstrapping on Linux..."

    echo "# Installing packages..."
    PACKAGES="python python3 vim-enhanced perl git19 curl python-pip python-setuptools"
    sudo yum -y install $PACKAGES >/dev/null 2>&1
    for pkg in $PACKAGES; do
        rpm -q $pkg >/dev/null 2>&1 || echo "Error! Failed to install package $pkg."
    done

    [ -f /etc/yum.repos.d/fish.repo ] && sudo rm /etc/yum.repos.d/fish.repo
    curl http://fishshell.com/files/linux/RedHat_RHEL-6/fish.release:2.repo 2>/dev/null | sudo tee /etc/yum.repos.d/fish.repo >/dev/null
    sudo yum -y install fish >/dev/null 2>&1
    rpm -q fish >/dev/null 2>&1 || echo "Error! Failed to install package fish."

    echo "# Installing/upgrading python packages..."
    pip install pip --upgrade
    pip install powerline-status --upgrade

    echo "# Install powerline fonts..."
    sh ~/mydots/powerline_fonts/install.sh

    echo "# Create symlinks for .vim, .vimrc and .config"
    for i in .vim .vimrc .config; do
        if [ -e ~/${i} ]; then
            if [ -e ~/${i}_before_bootstrap ]; then
                rm -r ~/${i}
            else
                mv ~/${i} ~/${i}_before_bootstrap
            fi
        fi
        ln -s ~/mydots/${i} .
    done

    echo "# Install VIM plugins..."
    vim +PluginInstall +qall

fi
