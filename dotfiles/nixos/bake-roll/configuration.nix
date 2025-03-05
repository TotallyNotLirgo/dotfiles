{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../configuration.nix
    ];
    networking.hostName = "bake-roll";
    system.stateVersion = "24.05";
}

