vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<F8>', vim.diagnostic.setloclist, { desc = 'Open diagnostics' })
vim.keymap.set("n", "<F9>", "<cmd>Trouble diagnostics<cr>", {silent = true, noremap = true})

vim.keymap.set({ 'n', 'v' }, '<C-h>', '10h')
vim.keymap.set({ 'n', 'v' }, '<C-j>', '10j')
vim.keymap.set({ 'n', 'v' }, '<C-k>', '10k')
vim.keymap.set({ 'n', 'v' }, '<C-l>', '10l')

vim.keymap.set({ "n", "v", "i", "t" }, "<F1>", "<Nop>")

vim.keymap.set({ "n", "v", }, "<C-h>", "10h")
vim.keymap.set({ "n", "v", }, "<C-j>", "10j")
vim.keymap.set({ "n", "v", }, "<C-k>", "10k")
vim.keymap.set({ "n", "v", }, "<C-l>", "10l")

vim.keymap.set({ "n", "v", "i", "t", }, "<LeftMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<RightMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<MiddleMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<2-LeftMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<2-RightMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<2-MiddleMouse>", "<Nop>")

vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "v" }, "K", ":m '>-2<CR>gv=gv")

vim.keymap.set({ "v" }, "<leader>y", "\"+y", { desc = "[Y]ank to system clipboard", })
vim.keymap.set({ "v" }, "p", "_dP", { desc = "[P]aste without copying replaced", })
vim.keymap.set({ "n", "v" }, "<leader>d", "_d", { desc = "[D]elete without copying", })

vim.keymap.set({ "n" }, "<leader>x", ":!chmod +x %<CR>", { desc = "Make e[X]ecutable", })
vim.keymap.set({ "n" }, "<leader>X", ":!chmod -x %<CR>", { desc = "Make not e[X]ecutable", })

vim.keymap.set({ "n" }, "gd", ":Lspsaga goto_definition<CR>", { desc = "[G]o to [D]efinition", })
vim.keymap.set({ "n" }, "K", ":Lspsaga peek_definition<CR>")
vim.keymap.set({ "n" }, "<leader>o", ":Lspsaga outline<CR>", { desc = "Open [O]utline", })
