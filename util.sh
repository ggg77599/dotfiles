#! /bin/sh
#
# utilFunction.sh
# Copyright (C) 2019 mrg <mrg@MrGMacBookPro>
#
# Distributed under terms of the MIT license.
#

# all customized function collect at this file

dCount(){

    find $1 -type d -print0 | while read -d '' -r dir; do
        files=("$dir"/*)
        printf "%5d files in directory %s\n" "${#files[@]}" "$dir"
    done

}

venv()
{
    p='-'  # any string as init
    
    until [ $p == '/' ]
    do
        if [ $p == '-' ]; then  # init as 
            p=`pwd`
        else
            p=$(dirname $p)
        fi
    
        #echo $p
        #echo ${p##*/}

        if [ -e ~/venv/${p##*/}/bin/activate ] ; then
            . ~/venv/${p##*/}/bin/activate
            break
        fi
    
    done
}



