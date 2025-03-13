{ pkgs, ... }:
{
    plugins = {
        sleuth.enable = true;
        web-devicons.enable = true;
        gitsigns = {
            enable = true;
            settings.signs = {
                add = { text = "+"; };
                change = { text = "~"; };
                delete = { text = "_"; };
                topdelete = { text = "‾"; };
                changedelete = { text = "~"; };
            };
        };
        nvim-autopairs.enable = true;
        indent-blankline = {enable = true; settings.scope.enabled = false;};
        trouble.enable = true;
        illuminate.enable = true;
        comment = {
            enable = true;
            settings = {
                opleader = { line = "<C-_>"; };
                toggler = { line = "<C-_>"; };
            };
        };
        colorizer.enable = true;
        oil = {
            enable = true;
            settings = {
                view_options.show_hidden = true;
            };
        };
        which-key.enable = true;
        visual-multi.enable = true;
        undotree.enable = true;
        persistence.enable = true;
        lualine = {
            enable = true;
            settings = {
                sections = {
                    lualine_b = [ "diagnostics" ];
                    lualine_c = [
                        {
                            __unkeyed-1 = "filename";
                            file_status = true;
                            path = 1;
                            symbols = {
                                modified = "";
                                readonly = "";
                                unnamed = "[No Name]";
                            };
                        }
                    ];
                    lualine_x = [ "filetype" ];
                    lualine_y = [];
                };
            };
        };
        telescope = {
            enable = true;
            keymaps = {
                "<leader>sg" = "live_grep";
                "<leader>sf" = "find_files";
                "<leader>sr" = "resume";
                "<leader>sb" = "buffers";
            };
            extensions = {
                fzf-native = {
                    enable = true;
                    settings = {
                        fuzzy = false;
                        override_generic_sorter = true;
                        override_file_sorter = true;
                        case_mode = "smart_case";
                    };
                };
                ui-select.enable = true;
            };
        };
    };
    extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
            pname = "ftFT.nvim";
            version = "1.0.0";
            src = pkgs.fetchFromGitHub {
                owner = "gukz";
                repo = "ftFT.nvim";
                rev = "f3e43c9584e14b27f04c27a95a9d9f0e58dfec02";
                sha256 = "sha256-y3TL64lkqLWx+GoG1Pj1DSQgMnL5cwtqOP5wsXVdz8k";
            };
        })
    ];
    extraConfigLua = ''
        require('ftFT').setup({
            keys = { "f", "t", "F", "T" },
            modes = { "n", "v" },
            hl_group = "VisualNOS",
            config = true
        })
    '';
}
