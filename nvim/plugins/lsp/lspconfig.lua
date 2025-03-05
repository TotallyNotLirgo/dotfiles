require('fidget').setup({})
require('cmp_nvim_lsp').setup()
require('lazydev').setup({ library = { path = { path = "luvit-meta/library", words = { "vim%.uv" } } } })
require('lsp_signature').setup({
    hint_enable = false
})
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('<F2>', vim.lsp.buf.rename, 'Rename')

        -- Highlights references to the word under cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        ---@diagnostic disable-next-line: undefined-field
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {
    settings = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    },
    capabilities = capabilities,
}
lspconfig.pyright.setup {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                diagnosticSeverityOverrides = {
                    reportInvalidTypeForm = "none",
                }
            }
        }
    },
    capabilities = capabilities,
}
lspconfig.gopls.setup {
    capabilities = capabilities,
}
lspconfig.jdtls.setup {
    capabilities = capabilities,
}
lspconfig.phpactor.setup {
    capabilities = capabilities,
}
lspconfig.cssls.setup {
    capabilities = capabilities,
}
lspconfig.html.setup {
    capabilities = capabilities,
}
lspconfig.htmx.setup {
    capabilities = capabilities,
}
lspconfig.tsserver.setup {
    init_options = {
        tsserver = {
            path = "/nix/store/alw6svgjp7172h9wssjqj2gm8bi7b4zp-typescript-5.5.3/lib/node_modules/typescript/lib"
        }
    },
    capabilities = capabilities,
}
