{ pkgs, ... }:
with pkgs; [
    xorg.xinit
    dunst # Notification daemon
    picom # Shadow and transparency
    j4-dmenu-desktop # Application launcher
    dracula-theme
    lxappearance # Theme manager
    papirus-icon-theme
    networkmanagerapplet # Network manager icon in systray
    scrot # Screenshot tool
    sysstat # Network statistics in awesome
    arandr # Screen layout editor
    gpick # Color picker
    lightdm # Login screen
    pavucontrol # Volume control
    pamixer # Volume control from terminal
]
