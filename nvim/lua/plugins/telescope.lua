return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function () return vim.fn.executable 'make' == 1 end,
        },
    },
    config = function ()
        require('telescope').setup({
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

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local b = require('telescope.builtin')

        vim.keymap.set('n', '<leader>sr', b.resume)
        vim.keymap.set('n', '<leader>sb', b.buffers)
        vim.keymap.set('n', '<leader>sf', b.find_files)
        vim.keymap.set('n', '<leader>sg', b.live_grep)
    end
}
