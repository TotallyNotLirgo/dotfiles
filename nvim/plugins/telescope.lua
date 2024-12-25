local telescope = require('telescope')

telescope.setup({
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
        fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'fzf')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
