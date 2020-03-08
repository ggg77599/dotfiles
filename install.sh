#! /bin/sh
#
# install.sh
# Copyright (C) 2019 mrg <mrg@MrGMacBookPro.local>
#
# Distributed under terms of the MIT license.
#

printhelp()
{
    echo "Usage of install.sh"
    echo "    sh install.sh min              # bashrc + vimrc"
    echo "    sh install.sh basic            # linux packages + vimrc"
    echo "    sh install.sh dev              # linux packages + vim package"
    echo "    sh install.sh devycm           # linux packages + vim package + YCM"
}

updateVim()
{
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim +PlugInstall +qall
    echo install DONE
}


if [ -z $1 ] ; then  # if no $1, install minimal only
    printhelp
    exit
fi

if [ $1 = "min" ] || [ $1 = "basic" ] || [ $1 = "dev" ] || [ $1 = "devycm" ] ; then

    ## setup command prefix
    dotfiles_HOME=`pwd`
    echo "============================================================"
    echo "#             install minimal (bashrc + vimrc)             #"
    echo "============================================================"

    echo "============================================================ install packages"
    sudo apt-get update -y
    sudo apt-get install -y colordiff \
                            git \
                            vim \
                            python3-minimal \
                            ssh \
                            curl

    echo "============================================================ setup git"
    # python symbolic link
    cd /usr/bin/
    sudo ln -s -f python3 python
    cd $dotfiles_HOME

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

    echo "============================================================ setup bashrc"
    if grep -q ". ~/.bashrc.mrg" ~/.bashrc; then
        echo update dotfiles
    else
        echo ". ~/.bashrc.mrg" >> ~/.bashrc
        echo installing dotfiles
    fi
    cp bashrc ~/.bashrc.mrg

    echo "============================================================ setup util"
    if grep -q ". ~/.util.mrg" ~/.bashrc; then
        echo update util
    else
        echo ". ~/.util.mrg" >> ~/.bashrc
        echo installing util
    fi
    cp util ~/.util.mrg

    echo "============================================================ setup vim"
    mkdir -p ~/.vim/
    cp vimrc.mini ~/.vimrc


    if [ $1 = "basic" ] || [ $1 = "dev" ] || [ $1 = "devycm" ] ; then

        echo "============================================================"
        echo "#          install minimal (linux packages + vimrc)        #"
        echo "============================================================"


        echo "============================================================ install packages"
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential \
                                                               python3-dev \
                                                               python3-distutils \
                                                               tmux \
                                                               nfs-common \
                                                               htop \
                                                               iputils-ping \
                                                               net-tools \
                                                               locales \
                                                               tzdata

        echo "============================================================ setup packages"
        # install pip for python 3
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        sudo -H python3 get-pip.py
        rm -f get-pip.py

        # install pip packages
        sudo -H pip3 install virtualenv
        sudo -H pip3 install markdown-editor

        # fix locale
        sudo locale-gen en_US.UTF-8
        export LC_ALL="en_US.UTF-8"
        sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

        # set timezone
        sudo ln -snf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
        sudo sh -c "echo 'Asia/Taipei' > /etc/timezone"
        sudo dpkg-reconfigure -f noninteractive tzdata

        # setup tmux config
        cp tmux.conf ~/.tmux.conf

        # setup sqlite config
        cp sqliterc ~/.sqliterc

        if [ $1 = "dev" ] || [ $1 = "devycm" ] ; then
            echo "============================================================"
            echo "#         install dev (linux packages + vim package)       #"
            echo "============================================================"

            echo "============================================================ install packages"
            sudo apt-get install -y tree

            echo "============================================================ install fzf"
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            yes | ~/.fzf/install

            echo "============================================================ copy vimrc"
            cp vimrc ~/.vimrc

            if [ $1 = "devycm" ] ; then
                echo "============================================================"
                echo "#   install devycm (linux packages + vim package + YCM)    #"
                echo "============================================================"

                echo "============================================================ install packages"
                sudo apt-get install -y exuberant-ctags \
                                        cmake

                echo "============================================================ setup vimrc"
                sed -i -e 's/\"Plug/Plug/g' ~/.vimrc

                # copy C-family Semantic Completion Engine
                wget https://raw.githubusercontent.com/Valloric/ycmd/master/cpp/ycm/.ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
            fi

            echo "============================================================ install vim packages"
            updateVim

        fi
    fi
else
    printhelp
fi


