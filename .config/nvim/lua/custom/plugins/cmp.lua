return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    --customize cmp
    'onsails/lspkind.nvim',
  },
  config = function ()
    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    luasnip.config.setup {}

    local cmp_icons = {
      Text = '  ',
      Method = '  ',
      Function = '  ',
      Constructor = '  ',
      Field = '  ',
      Variable = '  ',
      Class = '  ',
      Interface = '  ',
      Module = '  ',
      Property = '  ',
      Unit = '  ',
      Value = '  ',
      Enum = '  ',
      Keyword = '  ',
      Snippet = '  ',
      Color = '  ',
      File = '  ',
      Reference = '  ',
      Folder = '  ',
      EnumMember = '  ',
      Constant = '  ',
      Struct = '  ',
      Event = '  ',
      Operator = '  ',
      TypeParameter = '  ',
    }

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
      },
      window = {
        completion = {
          side_padding = 0,
        },
      },
      formatting = {
        expandable_indicator = true,
        fields = { 'kind', 'abbr' },
        format = function(entry, vim_item)
          local kind = require('lspkind').cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            symbol_map = cmp_icons
          })(entry, vim_item)

          -- surround icon with whitespace
          local strings = vim.split(kind.kind, '%s', { trimempty = true })
          kind.kind = ' ' .. (strings[1] or '') .. ' '

          return kind
        end,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(function ()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }

    require('luasnip.loaders.from_snipmate').lazy_load()

    -- clear snippets on insert mode exit
    -- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*',
      callback = function()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
          and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require('luasnip').session.jump_active
        then
          require('luasnip').unlink_current()
        end
      end
    })

  end
}

