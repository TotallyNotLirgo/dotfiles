{ pkgs, config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../configuration.nix
    ];
    networking.hostName = "popcorn";
    system.stateVersion = "24.05";

    programs.steam.enable = true;
    programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
    };
    services.tailscale.enable = true;
    networking.extraHosts =
    ''
        127.0.0.1 magentodevpl.elmark.local
        127.0.0.1 magentodeven.elmark.local
        127.0.0.1 magentodevro.elmark.local
        127.0.0.1 ruggeddevpl.elmark.local
        127.0.0.1 ruggeddeven.elmark.local
        127.0.0.1 elmaticdevpl.elmark.local
        127.0.0.1 elmaticdeven.elmark.local
    '';
    networking.wireguard.interfaces = {
        wg0 = {
            ips = [ "10.165.224.5/24" ];
            listenPort = 51820;
            privateKeyFile = "/home/emily/wireguard-keys/private";

            peers = [

                {
                    publicKey = "DAT4V2Z8cTT7PGGE53K15iaeWU6E+VYxZmDi+Go0mkQ=";

                    allowedIPs = [ "10.165.224.0/24" ];
                    endpoint = "77.254.8.15:51820";
                    persistentKeepalive = 25;
                }
            ];
        };
    };
    nixpkgs.config.allowUnfree = true;
    virtualisation.virtualbox = {
        host = {
            enable = true;
            enableExtensionPack = true;
        };
        guest = {
            enable = true;
            dragAndDrop = true;
            seamless = true;
            clipboard = true;
        };
    };
    users.extraGroups.vboxusers.members = [ "emily" ];
    hardware.graphics.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    hardware.nvidia.prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };
    fileSystems."/mnt/elmark" = {
        device = "//192.168.5.9/DIT";
        fsType = "cifs";
        options = ["credentials=/home/emily/dit-credentials" "nofail" "uid=emily" "gid=users"];
    };
    fileSystems."/mnt/home-server" = {
        device = "//home-server/private";
        fsType = "cifs";
        options = ["credentials=/home/emily/home-credentials" "nofail" "uid=emily" "gid=users"];
    };
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
    environment.systemPackages = with pkgs; [
        viewnior
        haruna
        drawing
        krita
        libreoffice-qt-fresh
        audacity
        discord
        unstable.signal-desktop
        spotify
        inkscape
        obsidian
        brave
    ];
}

