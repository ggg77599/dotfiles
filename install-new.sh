# install packages
# colordiff
# rg
# fzf
# tree
# InconsolataNerdFont https://www.nerdfonts.com

# install script
version=$(git --version | awk '{print $3}')
curl "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-completion.bash" -o ~/.git-completion.bash
curl "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-prompt.sh" -o ~/.git-prompt.sh

# create symbolic links
ln -s $(PWD)/gitconfig ~/.gitconfig
ln -s $(PWD)/vimrc ~/.vimrc
ln -s $(PWD)/vimrc.plug ~/.vimrc.plug

# interactive to set PS1_ENV
cat << EOL >> ~/.bashrc
#============================= added by dotfiles ==============================
export MY_DOTFILES_DIR="$(PWD)"
export MY_PS1_ENV=""
source \${MY_DOTFILES_DIR}/bashrc
source \${MY_DOTFILES_DIR}/util
#============================= added by dotfiles ==============================
EOL
