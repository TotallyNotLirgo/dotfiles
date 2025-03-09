{ ... }:
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
}
