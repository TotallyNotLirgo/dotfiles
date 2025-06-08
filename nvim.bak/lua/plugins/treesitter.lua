return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function ()
        vim.defer_fn(function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "bash",
                    "go",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "nix",
                    "python",
                    "regex",
                    "sql",
                    "toml",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                    "svelte",
                    "typescript",
                    "javascript",
                    "css",
                    "html",
                    "c",
                },
                auto_install = false,
                sync_install = false,
                ignore_install = {},
                modules = {},
                highlight = { enable = true },
                indent = { enable = true },
            })
        end, 0)
    end
}
