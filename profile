# This file is sourced by login shells. The MacOS always uses login shells for terminal apps.

# Set default editor, might be overridden by ~/.bashrc
export EDITOR="vim"

# Source bashrc to make login shell have the same behavior as non-login shell
if [ "$BASH" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
