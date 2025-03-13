{ pkgs, inputs, config, lib, ... }:
let
    username = "emily";
    homeDirectory = "/home/${username}";
    homeFiles = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/.config/dotfiles/dotfiles";
in
{
    imports = [
        inputs.nixvim.homeManagerModules.nixvim
    ];
    home.username = username;
    home.homeDirectory = homeDirectory;
    home.stateVersion = "24.11";
    home.packages = [
        inputs.zen-browser.packages."${pkgs.system}".default
    ];

    home.file = {
        ".config/nixos".source = homeFiles + "/nixos";
        ".config/i3".source = homeFiles + "/i3/i3";
        ".config/i3status".source = homeFiles + "/i3/i3status";
        ".config/picom".source = homeFiles + "/picom";
        ".config/kitty".source = homeFiles + "/kitty";
        ".bashrc".source = homeFiles + "/.bashrc";
        ".Xmodmap".source = homeFiles + "/.Xmodmap";
        ".Xresources".source = homeFiles + "/.Xresources";
        ".profile".text = ''
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
          . "$HOME/.bashrc"
        '';
    };
    programs.nixvim = import ./nixvim { inherit pkgs; inherit lib; };
    programs.home-manager.enable = true;
    programs.rofi = {
        enable = true;
        theme = dotfiles/rofi.rasi;
        extraConfig = {
            modi = "drun,run,combi";
            combi-modi = "drun,run";
        };
    };
    programs.starship = {
        enable = true;
        enableBashIntegration = true;
        settings = {
            directory = {
                truncation_length = 0;
                style = "bold cyan";
            };
            git_branch = {
                format = "[$symbol$branch]($style)";
                style = "bold yellow";
                symbol = " ";
            };
            git_status = {
                format = "[\\[$untracked$modified$deleted$ahead_behind\\]]($style) ";
                modified = "~$count";
                untracked = "+$count";
                deleted = "-$count";
                style = "bold yellow";
            };
            python = {
                format = "[$symbol$pyenv_prefix($version )]($style)";
                version_format = "$major.$minor";
                symbol = "󱔎 ";
                style = "bold #E5C07A";
            };
            nix_shell = {
                format = "[$symbol shell]($style) ";
                style = "bold #62AEEF";
                symbol = "";
            };
            cmd_duration = {
                format = "[\\[$duration\\]]($style) ";
                min_time = 100;
                show_milliseconds = true;
                style = "bold #E5C07A";
            };
            package = {
                disabled = true;
            };
            character = {
                success_symbol = "[](#C678DD)";
                error_symbol = "[](#E5C07A)";
            };
            username = {
                format = "[$user]($style) ";
                style_user = "bold #62AEEF";
            };
            hostname = {
                format = "[$ssh_symbol]($style) ";
                style = "bold #62AEEF";
                ssh_symbol = "󰖟";
            };
        };
    };
    gtk.gtk2.configLocation = "${config.home.sessionVariables.XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    home.sessionVariables = {
        XDG_CONFIG_HOME = "${homeDirectory}/.config";
        XDG_DATA_HOME = "${homeDirectory}/.local/share";
        XDG_STATE_HOME = "${homeDirectory}/.local/state";
        XDG_CACHE_HOME = "${homeDirectory}/.cache";

        CUDA_CACHE_PATH = "${config.home.sessionVariables.XDG_CACHE_HOME}/nv";
        GOPATH = "${config.home.sessionVariables.XDG_DATA_HOME}/go";
        WINEPREFIX = "${config.home.sessionVariables.XDG_DATA_HOME}/wine";
        GNUPGHOME="${config.home.sessionVariables.XDG_DATA_HOME}/gnupg";
        GTK2_RC_FILES="${config.home.sessionVariables.XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
        XCOMPOSECACHE="${config.home.sessionVariables.XDG_CACHE_HOME}/X11/xcompose";
    };
}
