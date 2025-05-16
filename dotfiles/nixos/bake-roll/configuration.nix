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
    environment.systemPackages = with pkgs; [
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
