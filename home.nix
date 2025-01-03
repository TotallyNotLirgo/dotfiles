{ pkgs, inputs, xdg, ... }:
{
    home.username = "emilia";
    home.homeDirectory = "/home/emilia";
    home.stateVersion = "24.05";

    home.file = {
        ".config/alacritty".source = dotfiles/config/alacritty;
        ".config/awesome".source = dotfiles/config/awesome;
        ".config/nixos".source = dotfiles/config/nixos;
        ".config/picom".source = dotfiles/config/picom;
        ".local/share/applications/Calculator.desktop".source = dotfiles/local/share/applications/Calculator.desktop;
        ".local/share/applications/Umlet.desktop".source = dotfiles/local/share/applications/Umlet.desktop;
        ".local/share/backgrounds".source = dotfiles/local/share/backgrounds;
        ".local/share/icons/calculator.svg".source = dotfiles/local/share/icons/calculator.svg;
        ".local/share/icons/umlet.svg".source = dotfiles/local/share/icons/umlet.svg;
        ".bashrc".source = dotfiles/.bashrc;
        ".tmux.conf".source = dotfiles/.tmux.conf;
        ".Xmodmap".source = dotfiles/.Xmodmap;
        ".Xresources".source = dotfiles/.Xresources;
    };
    programs.home-manager.enable = true;
    nixpkgs = {
        overlays = [
            (final: prev: {
                vimPlugins = prev.vimPlugins // {
                    git-lazydev = prev.vimUtils.buildVimPlugin {
                        name = "lazydev";
                        src = inputs.nvim-lazydev;
                    };
                    git-luvit-meta = prev.vimUtils.buildVimPlugin {
                        name = "luvit-meta";
                        src = inputs.nvim-luvit-meta;
                    };
                    git-copilot = prev.vimUtils.buildVimPlugin {
                        name = "copilot";
                        src = inputs.nvim-copilot;
                    };
                    git-ftFT = prev.vimUtils.buildVimPlugin {
                        name = "ftFT";
                        src = inputs.nvim-ftFT;
                    };
                };
            })
        ];
    };
    programs.rofi = {
        enable = true;
        theme = dotfiles/rofi.rasi;
        pass.enable = true;
        extraConfig = {
            modi = "drun,run,calc,combi";
            combi-modi = "drun,run,calc";
        };
        plugins = with pkgs; [
            rofi-calc
        ];
    };
    programs.neovim = import ./nvim.nix { inherit pkgs; inherit inputs; };
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
}
