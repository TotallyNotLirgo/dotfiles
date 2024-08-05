local cmp = require 'cmp'
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
    },
    sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            symbol_map = cmp_icons
        }),
        fields = { 'kind', 'abbr' },
        expandable_indicator = true
    }
}


vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#A87AF6"})
