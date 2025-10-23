#!/bin/sh

DOTFILES_PATH="$HOME/.config/dotfiles"

symlink() {
    ln -sf "$DOTFILES_PATH/$1" "$HOME/$2"
}

symlink ".bashrc" ""
symlink "kitty" ".config"
symlink "nvim" ".config"
symlink "mimeapps.list" ".config"
symlink "starship.toml" ".config"
symlink "applications/nvim.desktop" ".local/share/applications"

