{ pkgs, ... }:

{
    services.displayManager.defaultSession = "none+awesome";
    services.xserver = {
        enable = true;
        windowManager.awesome = {
            enable = true;
            package = pkgs.awesome.overrideAttrs (
                old: {
                    src = pkgs.fetchFromGitHub {
                        owner = "awesomeWM";
                        repo = "awesome";
                        rev = "392dbc2";
                        sha256 = "sha256:093zapjm1z33sr7rp895kplw91qb8lq74qwc0x1ljz28xfsbp496";
                    };
                    patches = [];
                }
            );
        };
        displayManager = {
            lightdm = {
                enable = true;
                background = "/etc/nixos/backgrounds/WindRoseWallpaper.png";
                greeter.enable = true;
                greeters.slick = {
                    enable = true;
                    theme.name = "Dracula";
                    iconTheme.name = "Papirus";
                    cursorTheme.name = "Dracula-cursors";
                    extraConfig = ''
                        user-background = false
                        '';
                };
            };
        };
    };
    services.xrdp.enable = true;
    services.xrdp.defaultWindowManager = "awesome";

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
    ];
}


