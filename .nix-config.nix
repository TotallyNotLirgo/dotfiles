{ config, lib, pkgs, ... }:

{
    imports =
      [
        ./hardware-configuration.nix
      ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    time.timeZone = "Europe/Warsaw";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    services.printing.enable = true;
    hardware.pulseaudio.enable = true;
    programs.dconf.enable = true;

    services.xserver = {
      enable = true;
      windowManager.awesome = {
          enable = true;
          package = pkgs.awesome.overrideAttrs (
              old: {
                  src = pkgs.fetchFromGitHub {
                      owner = "awesomeWM";
                      repo = "awesome";
                      rev = "392dbc2";
                      sha256 = "sha256:093zapjm1z33sr7rp895kplw91qb8lq74qwc0x1ljz28xfsbp496";
                  };
                  patches = [];
              }
          );
      };
      displayManager = {
        lightdm = {
          enable = true;
          background = "/etc/nixos/backgrounds/WindRoseWallpaper.png";
          greeter = {
            enable = true;
          };
          greeters.slick = {
            enable = true;
            theme.name = "Dracula";
            iconTheme.name = "Papirus";
            cursorTheme.name = "Dracula-cursors";
            extraConfig = ''
              user-background = false
            '';
          };
        };
      };
    };

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

    users.groups.emilia = {
        gid = 1000;
    };
    users.groups.developers = {
        gid = 1001;
    };

    users.users.emilia = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "developers" "emilia" ];
      packages = with pkgs; [
        tree
      ];
    };

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" ];
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
    environment.systemPackages = with pkgs; [
      htop # Process viewer
      vim
      wget
      stow # Symlink for dotfiles
      dunst # Notification daemon
      pavucontrol # Volume control
      pamixer # Volume control from terminal
      ripgrep # Search tool
      fzf # Fuzzy finder
      picom # Shadow and transparency
      feh # Image viewer and wallpaper setter
      gvfs # Thunar lib
      xarchiver # GUI archiving tool
      j4-dmenu-desktop # Application launcher
      brightnessctl # Screen brightness control
      playerctl # Media player control
      killall
      git
      tmux # Terminal multiplexer
      docker
      rustup
      gcc
      nodejs_20
      python311
      python310
      dracula-theme
      lxappearance # Theme manager
      papirus-icon-theme
      networkmanagerapplet # Network manager icon in systray
      blueman # Bluetooth manager
      pass # Password manager
      gnupg # Encryption software
      tldr # Digestible command help
      xclip # Clipboard manager
      xsel # Clipboard manager
      scrot # Screenshot tool
      sysstat # Network statistics in awesome
      arandr # Screen layout editor
      gpick # Color picker
      jq # JSON processor
      lightdm # Login screen
      alacritty # Terminal
      neovim
      pgadmin4-desktopmode # PostgreSQL GUI
      xfce.thunar # File manager
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      spotify
      mongodb-compass
      brave
      firefox
      cnijfilter2 # Canon printer driver
      viewnior # Image viewer
      haruna # Video player
      drawing # Image editor
      krita # Advanced image editor
      libreoffice-qt-fresh
      gnumeric # Spreadsheet editor
      prismlauncher # Minecraft
      steam
      snixembed # Steam icon
    ];

    programs.steam.enable = true;

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    system.copySystemConfiguration = true;
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;


    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.05"; # Did you read the comment?

}

