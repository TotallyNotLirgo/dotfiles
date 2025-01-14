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

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    services.openssh.enable = true;
    networking.firewall.enable = false;
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
    services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    services.ratbagd.enable = true;

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.165.224.2/24" ];
      listenPort = 51820;
      privateKeyFile = "/home/emilia/wireguard-keys/private";

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
}
