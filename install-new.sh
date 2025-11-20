#!/usr/bin/env sh

### this script should be ran many times without errors

# exit when any steps failed!
set -e
# ensures no pipeline command failure is missed
set -o pipefail
# prevent unset variables
set -u

# install package manager
package_manager_install=""
if [ "$(uname -s)" = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  package_manager_install="brew install"
fi

# install packages
$package_manager_install git
$package_manager_install ripgrep
$package_manager_install fzf
$package_manager_install tree
# InconsolataNerdFont https://www.nerdfonts.com

# install/update git script
version=$(git --version | awk '{print $3}')
curl "https://raw.githubusercontent.com/git/git/v$version/contrib/completion/git-completion.bash" -o ~/.git-completion.bash
curl "https://raw.githubusercontent.com/git/git/v$version/contrib/completion/git-prompt.sh" -o ~/.git-prompt.sh

# create symbolic links
ln -s -f "$PWD/bashrc" ~/.bashrc
ln -s -f "$PWD/gitconfig" ~/.gitconfig
ln -s -f "$PWD/gitignore" ~/.gitignore
ln -s -f "$PWD/profile" ~/.profile
ln -s -f "$PWD/util" ~/.util
ln -s -f "$PWD/vimrc" ~/.vimrc
#ln -s -f "$PWD/vimrc.plug" ~/.vimrc.plug
#ln -s -f "$PWD/wezterm.lua" ~/.wezterm.lua
ln -s -f "$PWD/git-wt" /usr/local/bin/git-wt
ln -s -f "$PWD/git-url" /usr/local/bin/git-url

# -n to handle existing symlink to a dir
ln -s -f -n "$PWD/gitconfighook" ~/.gitconfighook
ln -s -f -n "$PWD/ghostty" ~/.config/ghostty
ln -s -f -n "$PWD/nvim" ~/.config/nvim
