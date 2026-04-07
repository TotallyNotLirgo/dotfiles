return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { "j-hui/fidget.nvim", opts = {}, }
    },
    config = function()
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = { enable = false },
                    }
                }
            },
            cssls = {},
            html = {},
            svelte = {},
            ts_ls = {},
            gopls = {},
            phpactor = {},
            rust_analyzer = {},
            glsl_analyzer = {},
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "basic",
                            diagnosticSeverityOverrides = {
                                reportInvalidTypeForm = "none",
                            },
                        },
                    },
                }
            }
        }

        for server_name in pairs(servers) do
            vim.lsp.config(server_name, servers[server_name])
            vim.lsp.enable(server_name)
        end
        vim.keymap.set(
            { "n" },
            "<leader>r",
            function()
                for server_name in pairs(servers) do
                    vim.lsp.enable(server_name, false)
                    vim.lsp.enable(server_name, true)
                end
            end
        );
    end
}
