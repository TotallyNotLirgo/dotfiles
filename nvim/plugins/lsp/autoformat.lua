local conform = require('conform')
conform.setup {
    notify_on_error = false,
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { "docformatter", "isort", "black" },
    },
}
conform.formatters.docformatter = { prepend_args = { '--in-place', '--pre-summary-newline' } }
conform.formatters.isort = { prepend_args = { '--profile', 'black', '--line-length', '79' } }
conform.formatters.black = { prepend_args = { '--line-length', '79' } }

vim.keymap.set({ 'n' }, '<leader>f', function()
    require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })
