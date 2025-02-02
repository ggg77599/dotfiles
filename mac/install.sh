# install brew
# https://brew.sh
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install tool
brew install bash
brew install bash-completion # add source command before setting PS1
brew install tree
brew install fzf     # fuzzy search
brew install ripgrep # grep alternative
brew install wget
brew install tldr # man alternative
brew install sops
brew install vim
brew install neovim
#brew deps --tree --installed

# install software
# https://formulae.brew.sh/cask/
brew install --cask appcleaner
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask iina
brew install --cask microsoft-remote-desktop
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask rectangle
brew install --cask sublime-text
brew install --cask tunnelblick
brew install --cask typora
brew install --cask logseq
brew install --cask docker
brew install --cask toggl-track

# at least open those app once
brew install --cask --no-quarantine qlmarkdown       # preview markdown
brew install --cask --no-quarantine syntax-highlight # preview code with highlight

# language support
brew install fnm    # node.js version manager
brew install rustup # rust version manager
brew install go
brew install python
