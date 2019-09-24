#! /bin/sh
#
# install.sh
# Copyright (C) 2019 mrg <mrg@MrGMacBookPro.local>
#
# Distributed under terms of the MIT license.
#

## setup command prefix
dotfiles_HOME=`pwd`

updateVim()
{
    if [ -d ~/.vim/bundle ]; then
        echo ~/.vim/bundle exist !

        vim +PluginUpdate +qall
        echo update DONE
    else
        mkdir -p ~/.vim/bundle
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

        vim +PluginInstall +qall
        echo install DONE
    fi
}

echo "============================================================"
echo "#             install minimal (bashrc + vimrc)             #"
echo "============================================================"

echo "=================================================== install packages"
sudo apt-get update -y
sudo apt-get install -y colordiff \
                           git \
                           vim \
                           python3-minimal \
                           ssh \
                           curl

echo "========================================================== setup git"
# install git lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install -y git-lfs
git lfs install

# git completion and prompt
version=`git --version | awk '{print $3}'`
wget "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-completion.bash" -O ~/.git-completion.bash
wget "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-prompt.sh"       -O ~/.git-prompt.sh

# setup git
cp gitconfig ~/.gitconfig

echo "======================================================= setup bashrc"
if grep -q ". ~/.bashrc.mrg" ~/.bashrc; then
    echo update myRC
else
    echo ". ~/.bashrc.mrg" >> ~/.bashrc
    echo installing myRC
fi
cp bashrc ~/.bashrc.mrg

echo "========================================================== setup vim"
cp vimrc.mini ~/.vimrc


if [ -z $1 ] ; then  # if no $1, install minimal only
    exit
    echo 
fi

if [ $1 = "basic" ] || [ $1 = "dev" ] || [ $1 = "devycm" ] ; then

    echo "============================================================"
    echo "#          install minimal (linux packages + vimrc)        #"
    echo "============================================================"


    echo "=================================================== install packages"
    sudo apt-get install -y build-essential \
                               python3-dev \
                               python3-distutils \
                               tmux \
                               nfs-common \
                               htop \
                               iputils-ping \
                               net-tools \
                               locales

    echo "======================================================= setup python"
    # install pip for python 3
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo -H python3 get-pip.py
    rm -f get-pip.py

    # python symbolic link
    cd /usr/bin/
    sudo ln -s -f python3 python
    cd $dotfiles_HOME

    ## setup pip
    mkdir -p ~/.pip/
    cp pip.conf ~/.pip/

    # install pip packages
    sudo -H pip3 install virtualenv

    echo "========================================================= fix locale"
    export LC_ALL="en_US.UTF-8"
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8


    echo "========================================================= setup tmux"
    # setup tmux config
    cp tmux.conf ~/.tmux.conf

    if [ $1 = "dev" ] ; then
        echo "============================================================"
        echo "#         install dev (linux packages + vim package)       #"
        echo "============================================================"

        echo "========================================================== setup vim"
        cp vimrc ~/.vimrc

        echo "=========================================== install vim packages"
        updateVim

    elif [ $1 = "devycm" ] ; then
        echo "============================================================"
        echo "#   install devycm (linux packages + vim package + YCM)    #"
        echo "============================================================"

        echo "=================================================== install packages"
        sudo apt-get install -y exuberant-ctags \
                                   cmake

        echo "========================================================== setup vim"
        cp vimrc ~/.vimrc
        sed -i -e 's/\"Plugin/Plugin/g' ~/.vimrc

        # copy C-family Semantic Completion Engine
        wget https://raw.githubusercontent.com/Valloric/ycmd/master/cpp/ycm/.ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py

        echo "=========================================== install vim packages"
        updateVim

        cd ~/.vim/bundle/YouCompleteMe
        ./install.py
    fi
fi



