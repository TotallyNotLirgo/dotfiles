{ pkgs, ... }:

{
    imports = [
        ./packages.nix
        ./services.nix
    ];

    boot.loader.systemd-boot = {
        enable = true;
        consoleMode = "max";
    };
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "Europe/Warsaw";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.emily = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
    };

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    environment.sessionVariables = {
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        GTK_THEME = "Dracula";
    };
}

