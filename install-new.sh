#!/usr/bin/env sh

### this script should be ran many times without errors

# exit when any steps failed!
set -e
# ensures no pipeline command failure is missed
set -o pipefail
# prevent unset variables
set -u

FORCE_UPGRADE=0
while [ $# -gt 0 ]; do
  case "$1" in
  -f | --force-upgrade)
    FORCE_UPGRADE=1
    ;;
  *)
    echo "Unknown option: $1" >&2
    exit 1
    ;;
  esac
  shift
done

# Detect brew -> install and eval
if ! command -v brew > /dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  OS="$(uname -s)"

  case "$OS" in
  Darwin)
    [ "$(uname -m)" = "arm64" ] && BREW_PREFIX="/opt/homebrew" || BREW_PREFIX="/usr/local"
    ;;
  Linux)
    BREW_PREFIX="/home/linuxbrew/.linuxbrew"
    # Fallback for non-root linuxbrew installs
    [ ! -d "$BREW_PREFIX" ] && [ -d "$HOME/.linuxbrew" ] && BREW_PREFIX="$HOME/.linuxbrew"
    ;;
  *)
    echo "Unsupported Operating System: $OS"
    exit 1
    ;;
  esac

  eval "$("$BREW_PREFIX/bin/brew" shellenv)"
fi

if ! command -v brew > /dev/null 2>&1; then
  echo "Error: Homebrew installation failed or could not be found."
  exit 1
fi

# install a package if missing; with --force-upgrade, upgrade it if already installed
install_pkg() {
  pkg="$1"
  if brew list --formula "$pkg" > /dev/null 2>&1 || brew list --cask "$pkg" > /dev/null 2>&1; then
    if [ "$FORCE_UPGRADE" -eq 1 ]; then
      echo "Upgrading $pkg..."
      brew upgrade "$pkg"
    else
      echo "$pkg already installed, skipping."
    fi
  else
    echo "Installing $pkg..."
    brew install "$pkg"
  fi
}

# install packages
install_pkg git
install_pkg git-lfs
install_pkg ripgrep
install_pkg fzf
install_pkg fd
install_pkg jq
install_pkg yq
install_pkg tree
install_pkg unzip
install_pkg go
install_pkg fnm
install_pkg rustup
install_pkg python
install_pkg uv
# for neovom
install_pkg tree-sitter-cli
install_pkg luarocks
# InconsolataNerdFont https://www.nerdfonts.com

# install/update git script
version=$(git --version | awk '{print $3}')
curl "https://raw.githubusercontent.com/git/git/v$version/contrib/completion/git-completion.bash" -o ~/.git-completion.bash
curl "https://raw.githubusercontent.com/git/git/v$version/contrib/completion/git-prompt.sh" -o ~/.git-prompt.sh
curl "https://raw.githubusercontent.com/junegunn/fzf-git.sh/refs/heads/main/fzf-git.sh" -o ~/.fzf-git.sh

# create symbolic links
ln -s -f "$PWD/bashrc" ~/.bashrc
ln -s -f "$PWD/gitconfig" ~/.gitconfig
ln -s -f "$PWD/gitignore" ~/.gitignore
ln -s -f "$PWD/profile" ~/.profile
ln -s -f "$PWD/util" ~/.util
ln -s -f "$PWD/vimrc" ~/.vimrc
ln -s -f "$PWD/sqliterc" ~/.sqliterc
ln -s -f "$PWD/tmux.conf" ~/.tmux.conf
#ln -s -f "$PWD/vimrc.plug" ~/.vimrc.plug
#ln -s -f "$PWD/wezterm.lua" ~/.wezterm.lua
mkdir -p "$HOME/.local/bin"
ln -s -f "$PWD/git-wt" "$HOME/.local/bin/git-wt"
ln -s -f "$PWD/git-url" "$HOME/.local/bin/git-url"
ln -s -f "$PWD/git-aic" "$HOME/.local/bin/git-aic"

# -n to handle existing symlink to a dir
ln -s -f -n "$PWD/gitconfighook" ~/.gitconfighook
ln -s -f -n "$PWD/ghostty" ~/.config/ghostty
ln -s -f -n "$PWD/nvim" ~/.config/nvim

mkdir -p "$HOME/Development"
mkdir -p "$HOME/venv"
