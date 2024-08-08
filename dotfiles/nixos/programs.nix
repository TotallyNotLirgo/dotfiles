{ pkgs, ... }:

{
    programs.steam.enable = true;
    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-qt;
    };
    programs.xfconf.enable = true;
    programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
            thunar-media-tags-plugin
            thunar-volman
        ];
    };
}


