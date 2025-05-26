{ pkgs, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../configuration.nix
    ];
    networking.hostName = "bake-roll";
    system.stateVersion = "24.05";

    services.tailscale.enable = true;
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
    networking.wireguard = {
        interfaces = {
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
    };
    programs.steam.enable = true;
    programs.thunderbird.enable = true;
    virtualisation.virtualbox = {
        host.enable = true;
        host.enableExtensionPack = true;
        guest.enable = true;
        guest.dragAndDrop = true;
    };


    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia" ];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    hardware.keyboard.qmk.enable = true;
    services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
      };

    environment.systemPackages = with pkgs; [
        via
        qmk
        qmk-udev-rules
        aseprite
        prismlauncher
        obs-studio
        viewnior # Image viewer
        haruna # Video player
        drawing # Image editor
        krita # Advanced image editor
        libreoffice-qt-fresh
        audacity
        discord
        unstable.signal-desktop-bin
        spotify
        inkscape
        obsidian
        unstable.vintagestory
        unstable.dotnet-runtime_7
        vpnc
        networkmanager-vpnc
        android-tools
        heimdall
        heimdall-gui
        telegram-desktop
    ];
    fileSystems."/mnt/home-server" = {
        device = "//192.168.0.100/private";
        fsType = "cifs";
        options = [ "credentials=/home/emily/server-credentials" "nofail" "uid=emily" "gid=users"];
    };
}
