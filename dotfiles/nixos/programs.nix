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
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            gst_all_1.gst-plugins-good
            webkitgtk_4_1
        ];
    };
}


