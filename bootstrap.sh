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

    if [ ! -f /usr/local/bin/brew ]; then
        echo "Brew is not installed. Let's install that first."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo ""
    fi

    echo "# Updating brew and pouring some packages..."
    brew update
    brew install cmake python python3 ruby perl git fish httpie
    brew install the_silver_searcher wget htop nmap ipcalc pidof
    brew install tree wakeonlan dos2unix tcping watch jq node
    brew tap neovim/neovim
    brew install neovim
    brew tap caskroom/versions
    brew tap caskroom/cask
    brew cask install atom java iterm2 virtualbox virtualbox-extension-pack
    brew cask install vagrant appcleaner
    [ $do_upgrade -eq 1 ] && brew upgrade
    brew cleanup
    brew cask cleanup
    echo ""

    export PATH="/usr/local/opt/python/libexec/bin:$PATH"

    if ! grep -q '/usr/local/bin/fish' /etc/shells; then
        echo "# Allow use of fish as shell"
        echo '/usr/local/bin/fish' | sudo tee -a /etc/shells >/dev/null 2>&1
        echo ""
    fi

    echo "# Installing/upgrading python packages..."
    pip install --upgrade pip setuptools powerline-status awscli ansible
    pip install --upgrade neovim pip-tools psutil bottle glances virtualfish
    echo ""

    echo "# Installing/upgrading nodejs packages..."
    npm install -g serverless
    [ $do_upgrade -eq 1 ] && npm upgrade -g serverless npm
    echo ""

    echo "# Install powerline fonts..."
    if [ -d $BASEDIR/powerline ]; then
        cd $BASEDIR/powerline
        git pull
        cd $OLDPWD
    else
        git clone https://github.com/powerline/fonts.git $BASEDIR/powerline
    fi
    sh $BASEDIR/powerline/install.sh
    echo ""

    echo "# Install vim-plug."
    if [ ! -e $BASEDIR/.config/nvim/autoload/plug.vim ]; then
        curl -fLo $BASEDIR/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    echo "# Create .config symlink."
    for i in .ansible.cfg .gitignore .config; do
        if [ -e ~/${i} ]; then
            echo "-- $i"
            if [ -e ~/${i}_before_bootstrap ]; then
                rm -r ~/${i}
            else
                mv ~/${i} ~/${i}_before_bootstrap
            fi
        fi
        ln -s $BASEDIR/${i} ~/${i}
    done

    echo "# Install vim plugins."
    nvim +PlugInstall +qall

elif [ "$OS" == "Linux" ]; then
    echo "Bootstrapping on Linux... no longer supported."
    exit 1
fi
