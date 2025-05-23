# install brew
# https://brew.sh
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install tool
brew install bash
brew install bash-completion # add source command before setting PS1
brew install tree
brew install fzf     # fuzzy search
brew install ripgrep # grep alternative
brew install fd      # find alternative
brew install wget
brew install tldr # man alternative
brew install sops
brew install neovim
brew install docker
brew install docker-buildx
brew install docker-compose
brew install docker-credential-helper
brew install docker-completion
brew install colima # docker alternative ( open source )
# list all dependancy
#   brew deps --tree --installed

# install software
# https://formulae.brew.sh/cask/
brew install --cask appcleaner
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask iina
brew install --cask microsoft-remote-desktop
brew install --cask visual-studio-code
brew install --cask notion # note taking
brew install --cask rectangle
brew install --cask sublime-text
brew install --cask tunnelblick # openvpn client
brew install --cask typora      # markdown editor
brew install --cask obsidian    # note taking
brew install --cask orbstack
brew install --cask toggl-track

# at least open those app once
brew install --cask --no-quarantine qlmarkdown       # preview markdown
brew install --cask --no-quarantine syntax-highlight # preview code with highlight

# language support
brew install fnm    # node.js version manager, for neovim mason to install packages
brew install rustup # rust version manager, use rustup-init to install
brew install go
brew install python

## install go packages
go install github.com/rakyll/gotest  # colorful test results
go install github.com/cweill/gotests # generate test file
