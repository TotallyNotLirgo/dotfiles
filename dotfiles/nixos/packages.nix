{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        htop # Process viewer
        wget
        brightnessctl # Screen brightness control
        playerctl # Media player control
        killall
        tldr # Digestible command help
        xclip # Clipboard manager
        xsel # Clipboard manager
        xarchiver # Archive manager
        nemo-with-extensions
        nemo-fileroller
        file-roller
        xorg.xinit
        xorg.xkill
        picom # Shadow and transparency
        dracula-theme
        lxappearance # Theme manager
        papirus-icon-theme
        networkmanagerapplet # Network manager icon in systray
        pasystray # Pulse audio icon in systray
        scrot # Screenshot tool
        arandr # Screen layout editor
        gpick # Color picker
        pavucontrol # Volume control
        feh
        kitty
        libsForQt5.qt5.qtgraphicaleffects
        vim
        ripgrep # Search tool
        fzf # Fuzzy finder
        git
        dbeaver-bin
        nix-index
        firefox
        keepassxc
    ];
}
