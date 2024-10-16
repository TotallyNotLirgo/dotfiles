{ config, pkgs, ... }:

{
    # networking.networkmanager.enable = true;
    services.printing.enable = true;
    hardware.pulseaudio.enable = true;
    programs.dconf.enable = true;

    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0.0";
        touchpad.naturalScrolling = true;
    };

    hardware.opengl.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    services.openssh.enable = true;
    networking.firewall.enable = false;
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
    services.connman = {
        enable = true;
        package = pkgs.connmanFull;
    };
}
