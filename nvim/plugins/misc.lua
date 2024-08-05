require('nvim-autopairs').setup({})
require('ibl').setup({ scope = { enabled = false } })
require('auto-save').setup({})
require('ftFT').setup({
    keys = { "f", "t", "F", "T" },
    modes = {"n", "v"},   -- the modes this plugin works in.
    hl_group = "VisualNOS",  -- this property specify the hi group
    config = true
})
require('trouble').setup({})
---@diagnostic disable: missing-fields
require('Comment').setup({
    toggler = { line = '<C-_>', block = '<leader><C-_>' },
    opleader = { line = '<C-_>', block = '<leader><C-_>' }
})
