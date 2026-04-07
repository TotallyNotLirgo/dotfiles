return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    italic = false
                }
            })
            vim.cmd("colorscheme rose-pine-moon")
        end
    },
    'tpope/vim-abolish',
    'mbbill/undotree',
    "RRethy/vim-illuminate",
    "mg979/vim-visual-multi",
    { "j-hui/fidget.nvim",           opts = {} },
    { 'windwp/nvim-autopairs',       opts = {} },
    { 'kylechui/nvim-surround',      opts = {} },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "folke/trouble.nvim",          opts = {}, cmd = "Trouble" },
    { "folke/persistence.nvim",      opts = {}, event = "BufReadPre" },
    { 'folke/which-key.nvim',        opts = {}, event = 'VimEnter' },
    {
        "gukz/ftFT.nvim",
        keys = { "f", "t", "F", "T" },
        modes = { "n", "v" },
        hl_group = "VisualNOS",
        config = true,
    },
    {
        "alexpasmantier/pymple.nvim",
        filetypes = { "python" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "stevearc/dressing.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        build = ":PympleBuild",
        config = function()
            require("pymple").setup()
        end,
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup({
                keymaps = {
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                },
                view_options = {
                    show_hidden = true,
                }
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            sections = {
                lualine_b = { "diagnostics" },
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        symbols = {
                            modified = "",
                            readonly = "",
                            unnamed = "[No Name]"
                        }
                    }
                },
                lualine_x = { "filetype" },
                lualine_y = {}
            }
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = 'U' }
            },
        },
    }
}
