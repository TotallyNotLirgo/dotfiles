local n = { "n" }
local v = { "v" }
local nv = { "n", "v" }
local nvit = { "n", "v", "i", "t" }

local keymaps = {
    { n,    "<Esc>",           "<cmd>nohlsearch<CR>" },
    { n,    "<F9>",            "<cmd>Trouble diagnostics toggle<cr>" },

    { nvit, "<F1>",            "<Nop>" },

    { nv,   "<C-h>",           "10h" },
    { nv,   "<C-j>",           "10j" },
    { nv,   "<C-k>",           "10k" },
    { nv,   "<C-l>",           "10l" },

    { nvit, "<LeftMouse>",     "<Nop>" },
    { nvit, "<RightMouse>",    "<Nop>" },
    { nvit, "<MiddleMouse>",   "<Nop>" },
    { nvit, "<2-LeftMouse>",   "<Nop>" },
    { nvit, "<2-RightMouse>",  "<Nop>" },
    { nvit, "<2-MiddleMouse>", "<Nop>" },
    { nvit, "<3-LeftMouse>",   "<Nop>" },
    { nvit, "<3-RightMouse>",  "<Nop>" },
    { nvit, "<3-MiddleMouse>", "<Nop>" },

    { v,    "J",               ":m '>+1<CR>gv=gv" },
    { v,    "K",               ":m '<-2<CR>gv=gv" },

    { v,    "<leader>y",       "\"+y" },

    { n,    "<leader>x",       ":!chmod +x %<CR>" },
    { n,    "<leader>X",       ":!chmod -x %<CR>" },

    { n,    "gd",              ":Telescope lsp_definitions<CR>" },
    { n,    "gr",              ":Telescope lsp_references<CR>" },
    { n,    "<F2>",            vim.lsp.buf.rename },
    { n,    "K",               function() vim.lsp.buf.hover({ border = "rounded" }) end },
    { n,    "<leader>ee",      function() vim.diagnostic.open_float({ border = "rounded" }) end },
    { n,    "<leader>en",      function() vim.diagnostic.jump({ count = 1, float = { border = "rounded" } }) end },
    { n,    "<leader>ep",      function() vim.diagnostic.jump({ count = -1, float = { border = "rounded" } }) end },
    { n,    "<leader>f",       function() require('conform').format { async = false } end },
    { n,    "<leader>u",       ":UndotreeToggle<cr>" },

    { nv,   "<C-_>",           ":norm gcc<CR>" },

    { n,    "<backspace>",     ":Oil<CR>" }
}


vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4] or {});
end
