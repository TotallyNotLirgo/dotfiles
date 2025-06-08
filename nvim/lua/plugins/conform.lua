return {
    'stevearc/conform.nvim',
    opts = {
        notify_on_error = false,
        formatters_by_ft = {
            python = { "docformatter", "isort", "black" },
            go = { "golines" },
            _ = { lsp_format = "fallback" },
        },
        formatters = {
            black = {
                command = "black",
                prepend_args = { "--line-length", "79" },
            },
            isort = {
                command = "isort",
                prepend_args = { "--profile", "black", "--line-length", "79" },
            },
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
