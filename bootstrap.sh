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

    # Tools 
    brew tap neovim/neovim
    brew tap caskroom/versions
    brew tap caskroom/cask
    brew install dos2unix fish git git-flow glances gnu-tar jq neovim nmap ripgrep the_silver_searcher
    brew cask install alfred appcleaner boostnote firefox google-chrome java iterm2 spectacle

    # System tools
    brew install arping curl htop httpie ipcalc tcping tcptraceroute trash tree watch wget
    brew cask install docker postman

    # Go
    brew install go dep

    # Node
    brew install node

    # Python
    brew install pyenv pipenv python3

    # AWS
    brew tap aws/tap
    brew install aws-sam-cli awscli
    brew cask install aws-vault

    # Infra-as-code
    brew tap wata727/tflint
    brew install ansible cookiecutter packer terraform terraform-docs tflint 

    [ $do_upgrade -eq 1 ] && brew upgrade
    brew cleanup
    echo ""

    if ! grep -q '/usr/local/bin/fish' /etc/shells; then
        echo "# Allow use of fish as shell"
        echo '/usr/local/bin/fish' | sudo tee -a /etc/shells >/dev/null 2>&1
        echo ""
    fi

    echo "# Installing/upgrading python packages..."
    pip3 install --upgrade pip pip-tools setuptools psutil bottle virtualfish
    echo ""

    echo "# Installing/upgrading nodejs packages..."
    npm install -g serverless
    [ $do_upgrade -eq 1 ] && npm upgrade -g serverless npm
    echo ""

    echo "# Installing powerline-go..."
    if [ ! -f /usr/local/bin/powerline-go -o $do_upgrade -eq 1 ]; then
        POWERLINE_GO_VERSION=v1.12.1
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

    echo "# Install vim-plug."
    if [ ! -e $BASEDIR/.config/nvim/autoload/plug.vim ]; then
        curl -fLo $BASEDIR/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    echo "# Create .config symlink."
    for i in .gitignore .config .vimrc; do
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
