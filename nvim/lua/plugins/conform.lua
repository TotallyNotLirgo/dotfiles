return {
    'stevearc/conform.nvim',
    opts = {
        notify_on_error = false,
        formatters_by_ft = {
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            go = { "golines" },
            vue = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            css = { "prettier" },
            _ = { lsp_format = "fallback" },
        },
        formatters = {
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
