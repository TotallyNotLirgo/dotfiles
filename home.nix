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
                };
            })
        ];
    };
    programs.neovim = import ./nvim.nix { inherit pkgs; inherit inputs; };
}
