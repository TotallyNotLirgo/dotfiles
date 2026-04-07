return {
    'stevearc/conform.nvim',
    opts = {
        notify_on_error = false,
        formatters_by_ft = {
            python = { "docformatter", "ruff_organize_imports", "ruff_format" },
            go = { "golines" },
            _ = { lsp_format = "fallback" },
        },
        formatters = {
            docformatter = {
                command = "docformatter",
                prepend_args = { "--in-place", "--pre-summary-newline" },
            },
            golines = {
                command = "golines",
                prepend_args = { "-m", "80" },
            },
        },
    },
}
