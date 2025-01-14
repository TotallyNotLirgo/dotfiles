vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<F8>', vim.diagnostic.setloclist, { desc = 'Open diagnostics' })
vim.keymap.set("n", "<F9>", "<cmd>Trouble diagnostics<cr>", { silent = true, noremap = true })

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
vim.keymap.set({ "n", "v", "i", "t", }, "<3-LeftMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<3-RightMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "t", }, "<3-MiddleMouse>", "<Nop>")

vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "v" }, "<leader>y", "\"+y", { desc = "[Y]ank to system clipboard", })
vim.keymap.set({ "n", "v" }, "<leader>d", "_d", { desc = "[D]elete without copying", })

vim.keymap.set({ "n" }, "<leader>x", ":!chmod +x %<CR>", { desc = "Make e[X]ecutable", })
vim.keymap.set({ "n" }, "<leader>X", ":!chmod -x %<CR>", { desc = "Make not e[X]ecutable", })

vim.keymap.set({ "n" }, "<leader>R", ":LspRestart<CR>", { desc = "[R]estart LSP", })
vim.keymap.set({ "n" }, "gd", ":Lspsaga goto_definition<CR>", { desc = "[G]o to [D]efinition", })
vim.keymap.set({ "n" }, "K", ":Lspsaga hover_doc<CR>")
vim.keymap.set({ "n" }, "<leader>o", ":Lspsaga outline<CR>", { desc = "Open [O]utline", })
vim.keymap.set({ "n" }, "<leader>ee", ":Lspsaga show_line_diagnostics<CR>", { desc = "Show [E]rrors", })
vim.keymap.set({ "n" }, "<leader>ej", ":Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next Error", })
vim.keymap.set({ "n" }, "<leader>en", ":Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next Error", })
vim.keymap.set({ "n" }, "<leader>ek", ":Lspsaga diagnostic_jump_prev<CR>", { desc = "Jump to previous Error", })
vim.keymap.set({ "n" }, "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open [U]ndo tree", })

vim.keymap.set({ "n" }, "<leader>ss", ":Oil<CR>", { desc = "[S]how [S]ource tree", })
