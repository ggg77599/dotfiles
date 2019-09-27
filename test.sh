#! /bin/sh
#
# test.sh
# Copyright (C) 2019 mrg <mrg@msi-notebook>
#
# Distributed under terms of the MIT license.
#


printhelp()
{
    echo "Usage of install.sh"
    echo "    sh test.sh min              # bashrc + vimrc"
    echo "    sh test.sh basic            # linux packages + vimrc"
    echo "    sh test.sh dev              # linux packages + vim package"
    echo "    sh test.sh devycm           # linux packages + vim package + YCM"
}

checkCommand()
{
    if [ -z `which $1` ] ; then
        echo "command $1 not exist"
        exit
    fi
}

checkFile()
{
    if [ ! -e $1 ] ; then
        echo "file $1 not exist"
        exit
    fi
}


if [ -z $1 ] ; then  # if no $1, install minimal only
    printhelp
    exit
fi

if [ $1 = "min" ] || [ $1 = "basic" ] || [ $1 = "dev" ] || [ $1 = "devycm" ] ; then

    # test the command and configuration are exist !!

    checkCommand colordiff
    checkCommand git
    checkCommand vim
    checkCommand python3
    checkCommand python
    checkCommand ssh
    checkCommand curl

    checkFile ~/.gitconfig
    checkFile ~/.git-completion.bash
    checkFile ~/.git-prompt.sh
    #checkFile ~/.bashrc.mrg
    checkFile ~/.vimrc

    echo "test min OK"


    if [ $1 = "basic" ] || [ $1 = "dev" ] || [ $1 = "devycm" ] ; then

        checkCommand gcc
        checkCommand tmux
        checkCommand htop
        checkCommand ifconfig
        checkCommand ping
        checkCommand locale-gen
        checkCommand pip

        checkFile ~/.pip/pip.conf
        checkFile ~/.tmux.conf

        echo "test basic OK"

        if [ $1 = "dev" ] ; then

            checkFile ~/.vim/bundle/

            echo "test dev OK"

        elif [ $1 = "devycm" ] ; then

            checkFile ~/.vim/bundle/
            checkFile ~/.vim/bundle/YouCompleteMe/
            #checkFile ~/.vim/.ycm_extra_conf.py

            echo "test devycm OK"

        fi
    fi
else
    printhelp
fi


