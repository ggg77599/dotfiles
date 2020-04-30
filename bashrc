
# add alais
unalias -a
alias ls='ls -Fh --color'
alias ll='ls -al'
alias la='ls -a'
alias l='la'
alias grep='grep --color=auto'
alias rm='rm -i'
alias diff='colordiff'
alias pdb='python -m pdb'
alias v='vim'
alias p='python'
alias vd='vimdiff'
alias tree='tree -N'
alias wnv='watch -n 1 nvidia-smi'  # for nvidia graphic card
alias open='/usr/bin/xdg-open'  # open folder from command line

color_prompt=yes

# add git completed
source ~/.git-completion.bash
source ~/.git-prompt.sh

# set git prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWUNTRACKEDFILES=true


# set PS1 color
# '\u'=user, 'h'=host name, '\w'=full path
# 30=Black, 31=Red, 32=Green, 33=Yellow, 34=Blue, 35=Purple, 36=Cyan, 37=White
# 0=Regular, 1=Bold, 4=Underline
# reference : https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# MacBook
export PS1="\[\033[0;36m\]\u\[\033[m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;35m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "

# primary
export PS1="\[\033[0;35m\]\u\[\033[m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;34m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "

# test
export PS1="\[\033[4;32m\]\u\[\033[m\]@\[\033[4;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;35m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "

# basic

# dev


export TERM="xterm-256color"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Shift-Tab auto complete
set show-all-if-ambiguous on
bind '"\e[Z":menu-complete'




