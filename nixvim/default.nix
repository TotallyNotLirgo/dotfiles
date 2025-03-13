{ pkgs, lib, ... }:
{
    imports = [
        ./globals.nix
        ./keymaps.nix
        (import ./utility-plugins.nix { inherit pkgs; })
        (import ./language-plugins.nix { inherit pkgs; inherit lib; })
    ];
}
