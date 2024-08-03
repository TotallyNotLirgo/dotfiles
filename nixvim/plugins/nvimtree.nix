{
    nvim-tree = {
        enable = true;
        openOnSetup = true;
        openOnSetupFile = true;
        diagnostics = {
            enable = true;
            showOnDirs = true;
            showOnOpenDirs = false;
            severity = {
              min = "warn";
              max = "error";
            };
        };
        onAttach = {
          __raw = ''
          function(bufnr)
            local api = require "nvim-tree.api"
            local function opts(desc)
              return { buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set('n', '<C-k>', '10k', opts("disable <C-k>"))
          end
          '';
        };
    };
}
