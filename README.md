# Dot Files
Include bashrc, vimrc, gitconf, sqliterc, tmux.conf ...

## Description
* Modified from old repository *myRC*.
* Different mode to setup configuration and install packages I will use.

## Usage

```bash
sh install.sh min              # bashrc + vimrc
sh install.sh basic            # linux packages + vimrc
sh install.sh dev              # linux packages + vim packages
sh install.sh devycm           # linux packages + vim packages + YCM
```

## To Do List
- [x] reference DockerTest DockerFile
    - [x] set locale
    - [x] set timezone
- [ ] rearrange bashrc
    - [ ] difference level of PS1
        - [ ] according installed version ( min, basic, dev, devycm )
    - [ ] separate alias from bashrc
- [ ] rearrange vimrc
    - [ ] https://vimconfig.com
    - [ ] https://www.cnblogs.com/UnGeek/p/3318089.html
    - [ ] folding setting
        - [ ] vim view to store folding setting, before close
        - [ ] vim folding https://github.com/tmhedberg/SimpylFold
        - [ ] BufWinLeave, setting, https://vim.fandom.com/wiki/Make_views_automatic
- [ ] test vim-plug
- [ ] add pythonrc
- [ ] test ipython?
- [ ] some utility write by shell script
- [ ] add install type in some where
- [ ] set symbolic link from config file to this file
- [ ] add uninstall function

# Reference
* github search

