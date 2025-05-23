# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
alias wnv='watch -n 1 nvidia-smi' # for nvidia graphic card
#alias open='/usr/bin/xdg-open'  # open folder from command line
alias ibrew='arch -x86_64 /usr/local/Homebrew/bin/brew'
alias kc='kubectl'

alias giveMeWiFi="/usr/sbin/networksetup -setnetworkserviceenabled Wi-Fi on"

alias golint='golangci-lint --build-tags dynamic run '
alias golintv='golangci-lint --build-tags dynamic run -v '
alias sopsd='sops --input-type dotenv --output-type dotenv'
alias rg='rg --hidden'
#alias docker-compose='docker compose'
#alias readlink='greadlink -f'

#alias vim='nvim'

# for Golang
#alias gotest='go test --tags dynamic '
#alias gotestv='go test --tags dynamic -v '
#alias golint='golangci-lint --build-tags dynamic run '
#alias golintv='golangci-lint --build-tags dynamic run -v '
#alias sopsd='sops --input-type dotenv --output-type dotenv'

color_prompt=yes

# add git completed
source "$MY_DOTFILES_DIR"/.git-completion.bash
source "$MY_DOTFILES_DIR"/.git-prompt.sh

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

case "$MY_PS1_ENV" in
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
    export PS1="\[\033[0;35m\]\u\[\033[m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[1;33m\]\w \[\033[1;36m\]\$(__git_ps1 '(%s)')\[\033[m\]\$ "
    ;;
*)
    echo "using default PS1, set MY_PS1_ENV to configure"
    ;;
esac

# environment variable
export TERM="xterm-256color"
export LC_ALL=en_US.UTF-8

# setup tab for auto complete, show-all-if-ambiguous on
bind '"\e[Z":menu-complete' # Shift-Tab auto complete

# setup customized cd name
shopt -s cdable_vars
dev=~/Development
venv=~/venv

## ======================== package settings ==================================

# setup fnm for node, npm
eval "$(fnm env --use-on-cd --shell bash)"

# setup rustup-init for rustc, cargo
# DO NOT add `$(brew --prefix rustup)/bin` to the path, I would like to use rustup-init to manage my rust version
# https://rust-lang.github.io/rustup/installation/other.html#homebrew
. "$HOME/.cargo/env"

# setup bash completion, need to place bash-complete before fzf, or it will disable some command completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# setup fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
#export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
_fzf_setup_completion dir tree
_fzf_setup_completion path git kubectl kc sopsd
_fzf_setup_completion path code
_fzf_setup_completion path sops
_fzf_setup_completion path gotest
