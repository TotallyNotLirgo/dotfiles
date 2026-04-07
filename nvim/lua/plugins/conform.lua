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
            golines = {
                command = "golines",
                prepend_args = { "-m", "80" },
            },
        },
    },
}
