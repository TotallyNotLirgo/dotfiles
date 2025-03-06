{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../configuration.nix
    ];
    networking.hostName = "chip";
    system.stateVersion = "24.11";
}

