return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  config = function ()
    local function get_file_path()
      return vim.fn.fnamemodify(vim.fn.expand('%'), ":~:.")
    end
    require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_b = { 'diagnostics' },
          lualine_c = { get_file_path },
          lualine_x = { "filetype" },
          lualine_y = { },
        },
      extensions = { 'nvim-tree' }
    })
  end
}
