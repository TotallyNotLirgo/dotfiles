{ pkgs, ... }:
with pkgs; [
    vim
    ripgrep # Search tool
    fzf # Fuzzy finder
    git
    tmux # Terminal multiplexer
    docker
    rustup
    gcc
    nodejs_20
    python311
    python310
    jq # JSON processor
    alacritty # Terminal
    pgadmin4-desktopmode # PostgreSQL GUI
    mongodb-compass
]
