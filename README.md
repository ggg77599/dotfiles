# Dot Files
Include bashrc, vimrc, gitconf, sqliterc, tmux.conf ...

## Description
* Modified from old repository *myRC*.
* Different mode to setup configuration and install packages I will use.
* Using symbolic link to link config from `home` to this repo, make version control easier.
* To Be Refactor

## Usage

```bash
sh install.sh min              # bashrc + vimrc
sh install.sh basic            # linux packages + vimrc
sh install.sh dev              # linux packages + vim packages
sh install.sh devycm           # linux packages + vim packages + YCM
```

## To Do List
- [ ] make install modulized
- [ ] I need a source script, for bash completation and package setup
    - [ ] there are some env I will source by default, some are manual.
    - [ ] like gcp, nvm, bash-completation
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
- [ ] gitignore_global
- [ ] separate install different programming language
    - [ ] go
    - [ ] java
    - [ ] nodejs
- [ ] fzf
- [ ] ripgrep
- [ ] https://unix.stackexchange.com/questions/60530/vimdiff-disable-enable-color-coding
- [ ] new function for remove extra space at end of line
    * `sed -i '' 's/ *$//'`
- [ ] code format
    * https://github.com/dense-analysis/ale
- [ ] update configure
- [ ] change ubuntu default editor
- [ ] wsl set umask


# Reference
* github search
* https://github.com/Inndy/dotfiles/blob/master/vimrc