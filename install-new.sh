#!/usr/bin/env sh

### this script should be ran many times without errors

# exit when any steps failed!
set -e
# ensures no pipeline command failure is missed
set -o pipefail
# prevent unset variables
set -u

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

package_manager_install="brew install"

# install packages
$package_manager_install git
$package_manager_install git-lfs
$package_manager_install ripgrep
$package_manager_install fzf
$package_manager_install tree
$package_manager_install tree-sitter-cli
$package_manager_install uv
$package_manager_install fmn
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
sudo ln -s -f "$PWD/git-wt" /usr/local/bin/git-wt
sudo ln -s -f "$PWD/git-url" /usr/local/bin/git-url

# -n to handle existing symlink to a dir
ln -s -f -n "$PWD/gitconfighook" ~/.gitconfighook
ln -s -f -n "$PWD/ghostty" ~/.config/ghostty
ln -s -f -n "$PWD/nvim" ~/.config/nvim

mkdir -p "$HOME/Development"
mkdir -p "$HOME/venv"

# for claude-code
# TODO: rename CLAUDE.md to AGENTS.md
mkdir -p "$HOME/.claude/skills"
ln -s -f "$PWD/AI-Prompts/CLAUDE.md" ~/.claude/CLAUDE.md
ln -s -f "$PWD/AI-Prompts/CODE-REVIEW.md" ~/.claude/CODE-REVIEW.md
ln -s -f "$PWD/AI-Prompts/commands/code-review.md" ~/.claude/commands/code-review.md
ln -s -f "$PWD/AI-Prompts/skills/code-review" ~/.claude/skills/code-review
ln -s -f "$PWD/AI-Prompts/skills/update-pr-description" ~/.claude/skills/update-pr-description

# for codex-cli
mkdir -p "$HOME/.codex/skills"
ln -s -f "$PWD/AI-Prompts/CLAUDE.md" ~/.codex/AGENTS.md
ln -s -f "$PWD/AI-Prompts/CODE-REVIEW.md" ~/.codex/CODE-REVIEW.md
ln -s -f "$PWD/AI-Prompts/skills/code-review" ~/.codex/skills/code-review

# for gemini-cli
mkdir -p "$HOME/.gemini/skills"
ln -s -f "$PWD/AI-Prompts/CLAUDE.md" ~/.gemini/GEMINI.md
ln -s -f "$PWD/AI-Prompts/CODE-REVIEW.md" ~/.gemini/CODE-REVIEW.md
ln -s -f "$PWD/AI-Prompts/skills/code-review" ~/.gemini/skills/code-review
