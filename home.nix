{ ... }:

{
    home.username = "emilia";
    home.homeDirectory = "/home/emilia";
    home.stateVersion = "24.05";

    home.packages = [

    ];

    home.file = {
        ".config/alacritty".source = dotfiles/alacritty;
        ".config/awesome".source = dotfiles/awesome;
        ".local/share/backgrounds".source = dotfiles/backgrounds;
        ".config/dunst".source = dotfiles/dunst;
        ".config/nixos".source = dotfiles/nixos;
        ".config/nvim".source = dotfiles/nvim;
        ".config/picom".source = dotfiles/picom;
        ".bashrc".source = dotfiles/.bashrc;
        ".tmux.conf".source = dotfiles/.tmux.conf;
        ".Xmodmap".source = dotfiles/.Xmodmap;
        ".Xresources".source = dotfiles/.Xresources;
    };
    programs.home-manager.enable = true;
}
