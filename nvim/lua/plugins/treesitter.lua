return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
        local parsers = {
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
        }

        require("nvim-treesitter").install(parsers)

        local available = require("nvim-treesitter").get_available()

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local language = vim.treesitter.language.get_lang(args.match)
                if not language then
                    return
                end

                local function attach()
                    if not vim.treesitter.language.add(language) then
                        return
                    end
                    vim.treesitter.start(args.buf, language)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end

                local installed = require("nvim-treesitter").get_installed(parsers)
                local is_installed = vim.tbl_contains(installed, language)
                local can_install = vim.tbl_contains(available, language)
                if not is_installed and can_install then
                    require("nvim-treesitter").install(language):await(attach)
                else
                    attach()
                end
            end,
        })
    end
}
