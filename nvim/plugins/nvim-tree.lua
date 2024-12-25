local function on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts()
    return { buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<C-k>', '10k', opts())
end
require("nvim-tree").setup {
  renderer = {
    icons = {
      modified_placement = "before",
      glyphs = {
        modified = "",
      }
    }
  },
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
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  on_attach = on_attach
}
