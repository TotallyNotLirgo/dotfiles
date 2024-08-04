require("lualine").setup({
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_b = { 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { "filetype" },
    lualine_y = {},
  },
  extensions = { 'nvim-tree' }
})
