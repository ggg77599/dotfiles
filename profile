# This file is sourced by login shells. The MacOS always uses login shells for terminal apps.

# Set default editor, might be overridden by ~/.bashrc
export EDITOR="vim"

# Source bashrc to make login shell have the same behavior as non-login shell
if [ "$BASH" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Export PATH should be placed in the .profile
if [ "$(uname -s)" = "Darwin" ]; then
    # Mac OS package manager
    if [ "$(uname -m)" = "x86_64" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    else
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
elif [ "$(uname -s)" = "Linux" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi

case ":$PATH:" in
*":$HOME/.local/bin:"*) ;;
*) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# run `rustup-init` to setup rustc, cargo
# DO NOT add `$(brew --prefix rustup)/bin` to the path, I would like to use rustup-init to manage my rust version
# https://rust-lang.github.io/rustup/installation/other.html#homebrew
if command -v rustup-init > /dev/null 2>&1; then
    . "$HOME/.cargo/env"
fi
