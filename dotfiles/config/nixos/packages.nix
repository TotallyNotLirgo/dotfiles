{ pkgs, ... }:
let
    gaming = import ./packages/gaming.nix { inherit pkgs; };
    office = import ./packages/office.nix { inherit pkgs; };
    development = import ./packages/development.nix { inherit pkgs; };
    desktop = import ./packages/desktop.nix { inherit pkgs; };
in
{
    environment.systemPackages = with pkgs; [
        htop # Process viewer
        wget
        stow # Symlink for dotfiles
        brightnessctl # Screen brightness control
        playerctl # Media player control
        killall
        blueman # Bluetooth manager
        pass # Password manager
        pinentry-curses
        pinentry-tty
        pinentry-qt
        pinentry-gtk2
        qtpass
        gnupg # Encryption software
        tldr # Digestible command help
        xclip # Clipboard manager
        xsel # Clipboard manager
        xarchiver # Archive manager
        home-manager
        nemo-with-extensions
        nemo-fileroller
        file-roller
        wireguard-tools
    ]
    ++ gaming
    ++ office
    ++ development
    ++ desktop;
}
