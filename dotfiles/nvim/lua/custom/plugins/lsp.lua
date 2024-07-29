return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    -- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/neodev.nvim', opts = {} },

    'ray-x/lsp_signature.nvim',
  },
  config = function ()
    -- [[ configure lsp ]]
    --  this function gets run when an lsp connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- note: remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- in this case, we create a function that lets us more easily define mappings specific
      -- for lsp related items. it sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc, prefix)
        if desc and prefix then
          desc = '[L]sp: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame', true)
      nmap('<f2>', vim.lsp.buf.rename)
      nmap('<leader>lc', vim.lsp.buf.code_action, '[C]ode [A]ction', true)
      nmap('<C-.>', vim.lsp.buf.code_action)

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>ld', vim.lsp.buf.type_definition, 'Type [D]efinition', true)
      nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols', true)
      nmap('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols', true)

      -- see `:help k` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'hover documentation')

      -- lesser used lsp functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- create a command `:format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    local servers = {
      tsserver = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      }
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    require('lsp_signature').setup({
      hint_enable = false
    })

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }
  end
}
