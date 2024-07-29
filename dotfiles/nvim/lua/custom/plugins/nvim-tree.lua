return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('nvim-web-devicons').setup()
    require("nvim-tree").setup {
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.WARN,
          max = vim.diagnostic.severity.ERROR,
        },
      },
    }

    vim.keymap.set({ "n", "v", "i" }, "<C-l>", function () vim.cmd("NvimTreeToggle") end)
  end,
}
