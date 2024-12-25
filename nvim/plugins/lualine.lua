require("lualine").setup({
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_b = { 'diagnostics' },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
        symbols = {
          modified = '',
          readonly = '',
          unnamed = '[No Name]',
        }
      }
    },
    lualine_x = { "filetype" },
    lualine_y = {},
  },
  extensions = { 'nvim-tree' }
})
