{ pkgs, lib, ... }:
{
    imports = [
        ./globals.nix
        ./keymaps.nix
        ./utility-plugins.nix
        (import ./language-plugins.nix { inherit pkgs; inherit lib; })
    ];
}
