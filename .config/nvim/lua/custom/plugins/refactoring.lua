return {
  'theprimeagen/refactoring.nvim',
  opts = {},
  config = function()
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', require('telescope').extensions.refactoring.refactors,
      { desc = 'Select [R]efactor From List' })

    local function rmap(mode, key_suffix, refactor_name, desc)
      vim.keymap.set(mode, '<leader>r' .. key_suffix, function() require('refactoring').refactor(refactor_name) end,
        { desc = desc })
    end

    rmap({ 'n', 'x' }, 'i', 'Inline Variable', '[I]nline Variable')
    rmap('x', 'e', 'Extract Function', '[E]xtract Function')
    rmap('x', 'f', 'Extract Function To File', '[E]xtract Function To File')
    rmap('x', 'v', 'Extract Variable', '[E]xtract [V]ariable')
    rmap('n', 'e', 'Extract Block', '[E]xtract [B]lock')
    rmap('n', 'f', 'Extract Block To File', '[E]xtract [B]lock To File')
  end
}
