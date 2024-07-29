-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
-- vim.wo.relativenumber = true

-- tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- lines between cursor and window edge
vim.o.scrolloff = 8

vim.keymap.set('n', '<F1>', '<Nop>', { silent = true })


-- Enable mouse mode
vim.keymap.set({ 'n', 'v', 'i', 't' }, '<LeftMouse>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v', 'i', 't' }, '<RightMouse>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v', 'i', 't' }, '<MiddleMouse>', '<Nop>', { silent = true })
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.colorcolumn = "80"
vim.o.wrap = false

vim.opt.list = true
vim.opt.listchars = { tab = '› ', trail = '•', nbsp = '␣' }
