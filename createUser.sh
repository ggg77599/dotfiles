#! /bin/sh
#
# createUser.sh
# Copyright (C) 2019 mrg <mrg@MrGMacBookPro.local>
#
# Distributed under terms of the MIT license.
#

## setup command prefix
if [ $(whoami) = "root" ] ; then
    cmdPre=""
else
    cmdPre="sudo "
fi

# install sudo
$cmdpre apt-get update
$cmdpre apt-get install sudo

# add user, create home dir and set shell to bash
$cmdpre useradd -rm -d /home/mrg -s /bin/bash -p XN5w5Ucn5tHVE mrg

# set as sudo
$cmdpre usermod -aG sudo mrg

# set passwd
$cmdpre passwd mrg

