#! /bin/sh
#
# install.sh
# Copyright (C) 2019 mrg <mrg@MrGMacBookPro.local>
#
# Distributed under terms of the MIT license.
#




## minimal (bashrc + vimrc)
echo install minimal

# setup bashrc 
if grep -q ". ~/.bashrc.mrg" ~/.bashrc; then
    echo update myRC
else
    echo ". ~/.bashrc.mrg" >> ~/.bashrc
    echo installing myRC 
fi

# install packages
sudo apt-get update -y
sudo apt-get install colordiff -y
sudo apt-get install git -y
sudo apt-get install vim -y
sudo apt-get install python3-minimal -y
sudo apt-get install ssh -y
sudo apt-get install curl -y

# install git lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install

# git completion and prompt
version=`git --version | awk '{print $3}'`
wget "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-completion.bash" -O ~/.git-completion.bash 
wget "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-prompt.sh"       -O ~/.git-prompt.sh
cp gitconfig ~/.gitconfig

## setup vim 
cp vimrc.mini ~/.vimrc

if [ -z $1 ] ; then
    exit
fi

if [ $1 == "basic" ] || [ $1 == "dev" ]; then
    # basic (linux packages + vimrc)
    echo install basic

    # developer (linux packages + vim package)
    if [ $1 == "dev" ]; then
        echo install dev
    fi
fi




## install basic
#if [ $1 == "basic" ] || [ $1 == "dev" ]; then
#    echo install basic
#
#
#    # install developer
#    if [ $1 == "dev" ]; then
#        echo install dev
#    fi
#
#fi

