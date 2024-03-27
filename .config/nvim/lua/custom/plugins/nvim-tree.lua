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
      git = {
        enable = true,
        ignore = false,
        timeout = 400,
      },
    }

    vim.keymap.set({ "n", "v", "i" }, "<C-l>", function () vim.cmd("NvimTreeToggle") end)
  end,
}
