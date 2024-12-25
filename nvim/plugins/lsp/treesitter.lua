---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})

local query = require'vim.treesitter.query'

local sql_injection_query = [[
(function_definition
    name: (identifier) @fun (#match? @fun "query")
    body: (block
     (return_statement
       (string
         (string_content) @injection.content (#set! injection.language "sql")))))
]]

query.set("python", "injections", sql_injection_query)
