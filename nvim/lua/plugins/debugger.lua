return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python',
    },
    keys = {
        { '<leader>dr', function() require('dap').continue() end },
        { '<leader>dl', function() require('dap').step_into() end },
        { '<leader>dj', function() require('dap').step_over() end },
        { '<leader>dh', function() require('dap').step_out() end },
        { '<leader>dd', function() require('dap').toggle_breakpoint() end },
        { '<leader>dt', function() require('dap-python').test_method() end },
        { '<leader>D',  function() require('dapui').toggle() end },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup {
            icons = { expanded = '', collapsed = '', current_frame = '' },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 1 },
                    },
                    position = "left",
                    size = 40
                },
                {
                    elements = {
                        { id = "stacks",      size = 0.5 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "repl",        size = 0.25 }
                    },
                    position = "bottom",
                    size = 10
                },
            },
            controls = {
                icons = {
                    pause = '',
                    play = '',
                    step_into = '',
                    step_out = '',
                    step_back = '',
                    step_over = '',
                    run_last = '',
                    terminate = '',
                    disconnect = '',
                },
            },
        }

        vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#f38ba8' })
        vim.api.nvim_set_hl(0, 'DapStop', { fg = '#f9e2af' })
        local breakpoint_icons = {
            { 'Breakpoint', '', 'Break' },
            { 'BreakpointCondition', '', 'Break' },
            { 'BreakpointRejected', '', 'Break' },
            { 'LogPoint', '', 'Break' },
            { 'Stopped', '', 'Stop' }
        }
        for _, icons in ipairs(breakpoint_icons) do
            vim.fn.sign_define(
                'Dap' .. icons[1], {
                    text = icons[2],
                    texthl = 'Dap' .. icons[3],
                    numhl = 'Dap' .. icons[3]
                }
            )
        end
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        require('dap-go').setup({})
        require("dap-python").setup("uv")
    end,
}
