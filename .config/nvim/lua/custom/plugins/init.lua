return {
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {
    toggler = {
      line = '<C-_>',
      block = '<leader><C-_>'
    },
    opleader = {
      line = '<C-_>',
      block = '<leader><C-_>'
    }
  } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'mbbill/undotree', config = function ()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo Tree Toggle" })
  end
  },
  { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end },
  { 'windwp/nvim-autopairs', opts = {} },
  { 'kylechui/nvim-surround', opts = {} },
  { 'folke/trouble.nvim', opts = {}, config = function()
    vim.keymap.set("n", "<f8>", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
    vim.keymap.set("n", "<f9>", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
  end
  },
  {
    "gukz/ftFT.nvim",
    opts = {
        keys = { "f", "t", "F", "T" },
            modes = {"n", "v"},   -- the modes this plugin works in.
            hl_group = "VisualNOS",  -- this property specify the hi group
            config = true
        }
  },
  {
    'nullishamy/autosave.nvim',
    opts = { },
    lazy = false,
  },
  'github/copilot.vim'
}
