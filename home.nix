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
    programs.kitty = {
        enable = true;
        settings = {
            foreground = "#979eab";
            background = "#282c34";
            color0 = "#282c34";
            color1 = "#e06c75";
            color2 = "#98c379";
            color3 = "#e5c07b";
            color4 = "#61afef";
            color5 = "#be5046";
            color6 = "#56b6c2";
            color7 = "#979eab";
            color8 = "#393e48";
            color9 = "#d19a66";
            color10 = "#56b6c2";
            color11 = "#e5c07b";
            color12 = "#61afef";
            color13 = "#be5046";
            color14 = "#56b6c2";
            color15 = "#abb2bf";
            active_tab_foreground = "#abb2bf";
            active_tab_background = "#3B3F4C";
            inactive_tab_foreground = "#abb2bf";
            inactive_tab_background = "#31353F";
            active_tab_font_style = "normal";

            repaint_delay = 5;
            input_delay = 1;
            confirm_os_window_close = 0;
            font_size = 13;
            tab_bar_style = "powerline";
            tab_bar_min_tabs = 0;
            tab_title_template = "{f'{fmt.fg._98C379} {fmt.fg.tab}' if tab.active_exe == 'nvim' else f'{fmt.fg._E5C07B}󱔎 {fmt.fg.tab}' if tab.active_exe.startswith('python') else f'{fmt.fg._E06B74} {fmt.fg.tab}'}";
        };
        keybindings = {
            "alt+1" = "goto_tab 1";
            "alt+2" = "goto_tab 2";
            "alt+3" = "goto_tab 3";
            "alt+4" = "goto_tab 4";
            "alt+5" = "goto_tab 5";
            "alt+6" = "goto_tab 6";
            "alt+7" = "goto_tab 7";
            "alt+8" = "goto_tab 8";
            "alt+9" = "goto_tab 9";
            "alt+0" = "goto_tab 10";
            "ctrl+t" = "new_tab_with_cwd";
            "alt+s" = "new_window";
            "alt+q" = "close_window";
            "alt+j" = "prev_window";
            "alt+k" = "next_window";
        };
    };
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
    programs.helix = {
        enable = true;
    };
    programs.broot = {
        enable = true;
        enableBashIntegration = true;
        settings = {
            modal = true;
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
}
