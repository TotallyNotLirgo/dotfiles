{ config, pkgs, ... }:

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
    };

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.openssh.enable = true;
    networking.firewall.enable = false;

    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
    networking.wireguard.interfaces = {
        wg0 = {
            ips = [ "10.165.224.2/24" ];
            listenPort = 51820;
            privateKeyFile = "/home/emily/wireguard-keys/private";

            peers = [

                {
                    publicKey = "DAT4V2Z8cTT7PGGE53K15iaeWU6E+VYxZmDi+Go0mkQ=";

                    allowedIPs = [ "10.165.224.0/24" ];
                    endpoint = "192.168.0.100:51820";
                    persistentKeepalive = 25;
                }
            ];
        };
    };
    programs.steam.enable = true;
    programs.xfconf.enable = true;
    virtualisation.vmware.host.enable = true;
    fileSystems."/mnt/home-server" = {
        device = "//192.168.0.100/private";
        fsType = "cifs";
        options = [
            "credentials=/home/emily/server-credentials"
            "nofail"
        ];
    };
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
