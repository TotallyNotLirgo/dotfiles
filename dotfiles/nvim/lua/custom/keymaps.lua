vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew' })

-- quick lazy
vim.keymap.set('n', '<leader>Ls', ":Lazy sync<CR>", { desc = '[L]azy [s]ync' })
vim.keymap.set('n', '<leader>Lr', ":Lazy reload ", { desc = '[L]azy [r]eload' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", "j<C-e>")
vim.keymap.set("n", "<C-k>", "k<C-y>")

-- keep cursor in place when [J]oining lines
vim.keymap.set("n", "J", "mzJ`z")

-- center on cursor on common actions
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<leader>y", [["+y]], { desc = '[Y]ank to system clipboard' })

vim.keymap.set("v", "p", [["_dP]], { desc = '[P]aste without copying replaced' })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = '[D]elete without copying' })

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[S]ubstitute word under cursor" })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Mark file as e[x]ecutable' })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod -x %<CR>", { silent = true, desc = 'Mark file as non e[X]ecutable' })
local function format()
  if vim.bo.filetype == 'python' then
    vim.cmd(':silent !isort % --profile black --line-length 79')
    vim.cmd(':silent !black -l 79 %')
    vim.cmd(':silent !docformatter --in-place --pre-summary-newline %')
  else
    vim.cmd(':Format')
  end
end
vim.keymap.set('n', '<leader>f', format, { desc = 'Format with isort, black and docformatter' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
local function restart_buffer()
  -- save the line number
  local line = vim.fn.line('.')
  local file = vim.fn.expand('%')
  return ":bdel<CR>:e " .. file .. "<CR>:" .. line .. "<CR>"
end
vim.keymap.set('n', '<leader>r', restart_buffer, { desc = 'Restart buffer', expr = true, silent = true })

vim.keymap.set('n', '<leader>G', ':ma c<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>g', '`c', { noremap = true, silent = true })
