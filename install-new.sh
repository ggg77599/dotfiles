
# install packages
#colordiff
#rg
#fzf

# install script
version=`git --version | awk '{print $3}'`
curl "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-completion.bash" -o ~/.git-completion.bash
curl "https://raw.githubusercontent.com/git/git/v"$version"/contrib/completion/git-prompt.sh"       -o ~/.git-prompt.sh

# create symbolic links
ln -s $(PWD)/bashrc ~/.bashrc.mrg
ln -s $(PWD)/util ~/.util.mrg
ln -s $(PWD)/gitconfig ~/.gitconfig


# interactive to set PS1_ENV
#cat <<EOL >> ~/.bash_profile
#cat <<EOL >> ~/.bashrc
#export MY_DOTFILES_DIR=$(PWD)
#export MY_PS1_ENV=""
#source ~/.bashrc.mrg
#source ~/.util.mrg
#EOL



