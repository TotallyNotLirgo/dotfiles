{ pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./packages.nix
        ./programs.nix
        ./display.nix
        ./services.nix
        ./custom.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    time.timeZone = "Europe/Warsaw";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.emilia = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "developers" ];
    };

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    environment.sessionVariables = {
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
    # system.copySystemConfiguration = true;
    system.stateVersion = "24.05"; # Did you read the comment?
}

