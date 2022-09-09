
# add alais
unalias -a
alias ls='ls -Fh --color'
alias ll='ls -al'
alias la='ls -a'
alias l='la'
alias grep='grep --color=auto'
alias less='less -R'
alias rm='rm -i'
alias pdb='python -m pdb'
alias v='vim'
alias p='python'
alias vd='vimdiff'
alias tree='tree -N'
alias diff='colordiff'
alias wnv='watch -n 1 nvidia-smi'  # for nvidia graphic card
#alias open='/usr/bin/xdg-open'  # open folder from command line
alias ibrew='arch -x86_64 /usr/local/Homebrew/bin/brew'
alias work='cd /Users/gary_hsieh/Development/MGCP'
#alias readlink='greadlink -f'

color_prompt=yes

# add git completed
source ${MY_DOTFILES_DIR}/.git-completion.bash
source ${MY_DOTFILES_DIR}/.git-prompt.sh

# set git prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWUNTRACKEDFILES=true

## set PS1 color
## '\u'=user, 'h'=host name, '\w'=full path
##                     30=Black, 31=Red, 32=Green, 33=Yellow, 34=Blue, 35=Purple, 36=Cyan, 37=White
## Bold High Intensity 90=Black, 91=Red, 92=Green, 93=Yellow, 94=Blue, 95=Purple, 96=Cyan, 97=White
## 0=Regular, 1=Bold, 4=Underline
## reference : https://wiki.archlinux.org/index.php/Color_Bash_Prompt

case "${MY_PS1_ENV}" in
    MacBook)
        export PS1="\[\033[0;36m\]\u\[\033[m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;35m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "
        ;;
    primary)
        export PS1="\[\033[0;35m\]\u\[\033[m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;34m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "
        ;;
    test)
        export PS1="\[\033[4;32m\]\u\[\033[m\]@\[\033[4;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;35m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "
        ;;
    basic)
        echo basic
        ;;
    dev)
        echo dev
        ;;
    work)
        export PS1="\[\033[0;35m\]\u\[\033[m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;36m\]$(__git_ps1 '(%s)')\[\033[m\]$ "
        ;;
    *)
        using default PS1, set MY_PS1_ENV to configure
        ;;
esac


# environment variable
export TERM="xterm-256color"
export LC_ALL=en_US.UTF-8

#set show-all-if-ambiguous on
bind '"\e[Z":menu-complete' # Shift-Tab auto complete

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
# need to place bash-complete before fzf, or it will disable some command completion
# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
_fzf_setup_completion dir tree
_fzf_setup_completion path git kubectl
_fzf_setup_completion path code





