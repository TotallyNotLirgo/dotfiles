local cwd = vim.fn.getcwd()

local is_godot_project = vim.uv.fs_stat(cwd .. "/project.godot")

return {
    is_godot_project = is_godot_project,
    init = function()
        if is_godot_project then
            local is_server_running = vim.uv.fs_stat(cwd .. "/server.pipe")
            if not is_server_running then
                vim.fn.serverstart(cwd .. "/server.pipe")
            end
        end
    end,
}
