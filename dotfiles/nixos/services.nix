{ config, pkgs, ... }:

{
    networking.networkmanager.enable = true;
    services.printing.enable = true;
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

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    services.openssh.enable = true;
    networking.firewall.enable = false;
    networking.extraHosts =
        ''
        127.0.0.1 winter15.gosredirector.ea.com
        '';

    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
    # services.connman = {
    #     enable = true;
    #     package = pkgs.connmanFull;
    # };
     services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    services.ratbagd.enable = true;

}
