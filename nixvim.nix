{ pkgs, ... }:
{
    enable = true;
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    keymaps = [
        { mode = ["n"]; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; }
        { mode = ["n"]; key = "<F8>"; action = ":lua vim.diagnostic.setloclist()<cr>"; }
        { mode = ["n"]; key = "<F9>"; action = "<cmd>Trouble diagnostics<cr>"; }

        { mode = [ "n" "v" ]; key = "<C-h>"; action = "10h"; }
        { mode = [ "n" "v" ]; key = "<C-j>"; action = "10j"; }
        { mode = [ "n" "v" ]; key = "<C-k>"; action = "10k"; }
        { mode = [ "n" "v" ]; key = "<C-l>"; action = "10l"; }

        { mode = [ "n" "v" "i" "t" ]; key = "<F1>"; action = "<Nop>"; }

        { mode = [ "n" "v" ]; key = "<C-h>"; action = "10h"; }
        { mode = [ "n" "v" ]; key = "<C-j>"; action = "10j"; }
        { mode = [ "n" "v" ]; key = "<C-k>"; action = "10k"; }
        { mode = [ "n" "v" ]; key = "<C-l>"; action = "10l"; }

        { mode = [ "n" "v" "i" "t" ]; key = "<LeftMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<RightMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<MiddleMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<2-LeftMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<2-RightMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<2-MiddleMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<3-LeftMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<3-RightMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<3-MiddleMouse>"; action = "<Nop>"; }

        { mode = [ "v" ]; key = "J"; action = ":m '>+1<CR>gv=gv"; }
        { mode = [ "v" ]; key = "K"; action = ":m '<-2<CR>gv=gv"; }

        { mode = [ "v" ]; key = "<leader>y"; action = "\"+y"; }
        { mode = [ "n" "v" ]; key = "<leader>d"; action = "_d"; }

        { mode = [ "n" ]; key = "<leader>x"; action = ":!chmod +x %<CR>"; }
        { mode = [ "n" ]; key = "<leader>X"; action = ":!chmod -x %<CR>"; }

        { mode = [ "n" ]; key = "<leader>R"; action = ":LspRestart<CR>"; }
        { mode = [ "n" ]; key = "gd"; action = ":Telescope lsp_definitions<CR>"; }
        { mode = [ "n" ]; key = "gr"; action = ":Telescope lsp_references<CR>"; }
        { mode = [ "n" ]; key = "<F2>"; action = ":lua vim.lsp.buf.rename()<CR>"; }
        { mode = [ "n" ]; key = "K"; action = ":Lspsaga hover_doc<CR>"; }
        { mode = [ "n" ]; key = "<leader>o"; action = ":Lspsaga outline<CR>"; }
        { mode = [ "n" ]; key = "<leader>ee"; action = ":Lspsaga show_line_diagnostics<CR>"; }
        { mode = [ "n" ]; key = "<leader>ej"; action = ":Lspsaga diagnostic_jump_next<CR>"; }
        { mode = [ "n" ]; key = "<leader>en"; action = ":Lspsaga diagnostic_jump_next<CR>"; }
        { mode = [ "n" ]; key = "<leader>ek"; action = ":Lspsaga diagnostic_jump_prev<CR>"; }

        { mode = [ "n" ]; key = "<leader>u"; action = ":UndotreeToggle<cr>"; }

        { mode = [ "n" ]; key = "<backspace>"; action = ":Oil<CR>"; }
    ];

    globalOpts = {
        number = true;
        mouse = "a";
        breakindent = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        splitright = true;
        splitbelow = true;
        list = true;
        listchars = { tab = "› "; trail = "•"; nbsp = "␣"; };
        cursorline = true;
        scrolloff = 8;
        updatetime = 250;
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        completeopt = "menuone,noselect";
        termguicolors = true;
        colorcolumn = "80";
        wrap = false;
        clipboard = {
            providers = {
                xsel.enable = true;
            };
        };
    };

    colorschemes.catppuccin.enable = true;
    plugins = {
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
        lsp = {
            enable = true;
            servers = {
                lua_ls.enable = true;
                nil_ls.enable = true;
                gopls.enable = true;
                pyright = {
                    enable = true;
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true;
                                diagnosticMode = "workspace";
                                useLibraryCodeForTypes = true;
                                typeCheckingMode = "basic";
                                diagnosticSeverityOverrides = {
                                    reportInvalidTypeForm = "none";
                                };
                            };
                        };
                    };
                };
            };
        };
        treesitter = {
            grammarPackages =
                with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                    bash
                    go
                    json
                    lua
                    make
                    markdown
                    nix
                    python
                    regex
                    sql
                    toml
                    vim
                    vimdoc
                    xml
                    yaml
                ];
            enable = true;
            settings.autoInstall = false;
            settings.indent.enable = true;
            settings.highlight.enable = true;
            luaConfig.post = ''
                do
                    local query = require'vim.treesitter.query'

                    local sql_injection_query = [[
                    (function_definition
                     name: (identifier) @fun (#match? @fun "query")
                     body: (block
                         (return_statement
                          (string
                           (string_content) @injection.content (#set! injection.language "sql")))))
                    ]]

                    query.set("python", "injections", sql_injection_query)
                end
            '';
        };
        lspkind = {
            enable = true;
            mode = "symbol";
            cmp = {
                enable = true;
                maxWidth = 50;
            };
            symbolMap = {
                Text = "  ";
                Method = "  ";
                Function = "󰊕  ";
                Constructor = "󰊕  ";
                Field = "  ";
                Variable = "  ";
                Class = "  ";
                Interface = "  ";
                Module = "  ";
                Property = "  ";
                Unit = "  ";
                Value = "  ";
                Enum = "  ";
                Keyword = "  ";
                Snippet = "  ";
                Color = "  ";
                File = "  ";
                Reference = "  ";
                Folder = "  ";
                EnumMember = "  ";
                Constant = "  ";
                Struct = "  ";
                Event = "  ";
                Operator = "  ";
                TypeParameter = "  ";
                Copilot = "  ";
            };
        };
        cmp = {
            enable = true;
            autoEnableSources = true;
            settings = {
                completion = {
                    completeopt = "menu,menuone,noinsert";
                };
                mapping = {
                    "<CR>" = "cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace, }";
                    "<C-Space>" = "cmp.mapping.complete {}";
                    "<Down>" = "cmp.mapping.select_next_item()";
                    "<Up>" = "cmp.mapping.select_prev_item()";
                };
                sources = [
                    { name = "lazydev"; group_index = 0; }
                    { name = "luasnip"; }
                    { name = "nvim_lsp"; }
                    { name = "path"; }
                ];
                formatting = {
                    fields = [ "kind" "abbr" ];
                };
            };
        };
        lspsaga = {
            enable = true;
            symbolInWinbar.enable = false;
            lightbulb.enable = false;
            beacon.enable = false;
            outline.autoPreview = false;
            outline.keys.toggleOrJump = "<Return>";
        };
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
            };
            extensions = {
                fzf-native.enable = true;
                ui-select.enable = true;
            };
        };
    };
}
