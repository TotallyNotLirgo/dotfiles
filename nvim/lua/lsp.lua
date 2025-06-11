local servers = {
    lua = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
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
    typescript = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'typescript', 'javascript' },
        root_markers = { 'package.json' }
    },
    go = {
        cmd = { 'gopls' },
        filetypes = { 'go' },
    },
    rust = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml' }
    },
    python = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml' },
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
    vim.lsp.config[server_name] = servers[server_name]
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
end);
