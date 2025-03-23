{ pkgs, lib, ... }:
{
    plugins = {
        lsp-signature = {
            enable = true;
            settings = {
                hint_enable = false;
            };
        };
        lsp = {
            enable = true;
            servers = {
                lua_ls.enable = true;
                nil_ls.enable = true;
                volar.enable = true;
                ts_ls.enable = true;
                gopls = {
                    enable = true;
                    settings.gopls.buildFlags = ["-tags=test"];
                };
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
        conform-nvim = {
            enable = true;
            settings = {
                notify_on_error = false;
                formatters_by_ft = {
                    lua = ["stylua"];
                    python = ["docformatter" "isort" "black"];
                    go = ["golines"];
                    _ = [
                        "trim_whitespace"
                        "trim_newlines"
                    ];
                };
                formatters = {
                    black = {
                        command = lib.getExe' pkgs.python312Packages.black "black";
                        prepend_args = ["--line-length" "79"];
                    };
                    isort = {
                        command = lib.getExe' pkgs.python312Packages.isort "isort";
                        prepend_args = ["--profile" "black" "--line-length" "79"];
                    };
                    docformatter = {
                        command = lib.getExe pkgs.python312Packages.docformatter;
                        prepend_args = ["--in-place" "--pre-summary-newline"];
                    };
                    golines = {
                        command = lib.getExe' pkgs.golines "golines";
                        prepend_args = ["-m" "80"];
                    };
                };
            };
        };
    };
}
