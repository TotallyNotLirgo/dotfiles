{ pkgs, ... }:

{
    services.displayManager = {
        sddm = {
            enable = true;
            theme = "sugar-dark";
        };
        defaultSession = "none+awesome";
    };
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
    };

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
        noto-fonts-color-emoji
    ];
    fonts.fontconfig = {
        defaultFonts = {
            sansSerif = ["Liberation Sans" "Noto Color Emoji" "DejaVu Sans"];
            serif = ["Liberation Serif" "Noto Color Emoji" "DejaVu Serif"];
            monospace = ["FiraMono Nerd Font" "FiraCode Nerd Font"];
            emoji = ["Noto Color Emoji" "FiraCode Nerd Font"];
        };
    };
}


