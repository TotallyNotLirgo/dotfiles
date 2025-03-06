{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../configuration.nix
    ];
    networking.hostName = "chip";
    system.stateVersion = "24.11";
    fileSystems."/mnt/home-server" = {
        device = "//192.168.0.100/private";
        fsType = "cifs";
        options = [ "credentials=/home/emily/server-credentials" "nofail" ];
    };
}

