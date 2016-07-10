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

elif [ "$OS" == "Linux" ¥; then
    echo "Bootstrapping on Linux..."
fi
