{ pkgs, ... }:

{
    networking.networkmanager.enable = true;
    services.printing = {
        enable = true;
        drivers = with pkgs; [
            hplip
            cnijfilter2
        ];
    };
    services.pipewire.enable = false;
    hardware.pulseaudio.enable = true;
    programs.dconf.enable = true;

    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
        daemon.settings = {
            bip = "172.21.0.2/24";
        };
    };

    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0.0";
        touchpad.naturalScrolling = true;
        mouse.middleEmulation = false;
    };

    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.openssh.enable = true;
    networking.firewall.enable = false;

    programs.xfconf.enable = true;
    services.displayManager.ly.enable = true;
    services.xserver = {
        enable = true;
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
         ];
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
