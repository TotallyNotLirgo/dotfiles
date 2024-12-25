{ pkgs, inputs, ... }:
{
    home.username = "emilia";
    home.homeDirectory = "/home/emilia";
    home.stateVersion = "24.05";

    home.file = {
        ".config/alacritty".source = dotfiles/alacritty;
        ".config/awesome".source = dotfiles/awesome;
        ".local/share/backgrounds".source = dotfiles/backgrounds;
        ".config/nixos".source = dotfiles/nixos;
        ".config/picom".source = dotfiles/picom;
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
                format = "[\\[$modified$ahead_behind\\]]($style) ";
                modified = "$count";
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
        };
    };
}
