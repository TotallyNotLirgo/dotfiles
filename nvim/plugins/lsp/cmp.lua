local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_icons = {
    Text = '  ',
    Method = '  ',
    Function = '󰊕  ',
    Constructor = '󰊕  ',
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
    Copilot = '  '
}
cmp.setup {
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace, },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            symbol_map = cmp_icons,
        }),
        fields = { 'kind', 'abbr' },
        expandable_indicator = true
    },
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
}

require('luasnip.loaders.from_vscode').lazy_load()


vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#A87AF6"})

