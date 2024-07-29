-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()
    require('telescope').setup {
      defaults = {
        mappings = {
        i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    -- enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    local b = require('telescope.builtin')

    vim.keymap.set('n', '<leader>?', b.help_tags, { desc = '[?] Search help' })

    vim.keymap.set('n', '<leader><space>', b.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      -- you can pass additional configuration to telescope to change theme, layout, etc.
      b.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<C-f>', function()
      b.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end)

    vim.keymap.set('n', '<leader>sg', b.git_files, { desc = '[S]earch [G]it files' })
    vim.keymap.set('n', '<C-p>', b.git_files)

    vim.keymap.set('n', '<leader>sf', b.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<C-[>', b.find_files)

    vim.keymap.set('n', '<leader>sg', b.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<C-S-f>', b.live_grep)
    vim.keymap.set('n', '<leader>sr', b.oldfiles, { desc = '[S]earch [R]ecently opened files' })
    vim.keymap.set('n', '<leader>sw', b.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sd', b.diagnostics, { desc = '[S]earch [D]iagnostics' })

    vim.keymap.set('n', '<Esc>', function () end) -- escape executes b.find_files by default for some reason
  end
}

