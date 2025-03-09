{ ... }:
{
    enable = true;
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    colorschemes.catppuccin.enable = true;

    globalOpts = {
        number = true;
        mouse = "a";
        breakindent = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        splitright = true;
        splitbelow = true;
        list = true;
        listchars = { tab = "› "; trail = "•"; nbsp = "␣"; };
        cursorline = true;
        scrolloff = 8;
        updatetime = 250;
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        completeopt = "menuone,noselect";
        termguicolors = true;
        colorcolumn = "80";
        wrap = false;
        clipboard = {
            providers = {
                xsel.enable = true;
            };
        };
    };
    autoGroups = {
        yankGroup = {
            clear = true;
        };
    };
    autoCmd = [
        {
            command = "lua vim.highlight.on_yank()";
            group = "yankGroup";
            event = [
                "TextYankPost"
            ];
        }
        {
            callback = { __raw = ''
                function()
                    if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
                        require("persistence").select()
                    end
                end
            ''; };
            event = [
                "VimEnter"
            ];
            nested = true;
        }
    ];
}
