{ ... }:
{
    keymaps = [
        { mode = ["n"]; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; }
        { mode = ["n"]; key = "<F8>"; action = ":lua vim.diagnostic.setloclist()<cr>"; }
        { mode = ["n"]; key = "<F9>"; action = "<cmd>Trouble diagnostics<cr>"; }

        { mode = [ "n" "v" ]; key = "<C-h>"; action = "10h"; }
        { mode = [ "n" "v" ]; key = "<C-j>"; action = "10j"; }
        { mode = [ "n" "v" ]; key = "<C-k>"; action = "10k"; }
        { mode = [ "n" "v" ]; key = "<C-l>"; action = "10l"; }

        { mode = [ "n" "v" "i" "t" ]; key = "<F1>"; action = "<Nop>"; }

        { mode = [ "n" "v" ]; key = "<C-h>"; action = "10h"; }
        { mode = [ "n" "v" ]; key = "<C-j>"; action = "10j"; }
        { mode = [ "n" "v" ]; key = "<C-k>"; action = "10k"; }
        { mode = [ "n" "v" ]; key = "<C-l>"; action = "10l"; }

        { mode = [ "n" "v" "i" "t" ]; key = "<LeftMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<RightMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<MiddleMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<2-LeftMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<2-RightMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<2-MiddleMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<3-LeftMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<3-RightMouse>"; action = "<Nop>"; }
        { mode = [ "n" "v" "i" "t" ]; key = "<3-MiddleMouse>"; action = "<Nop>"; }

        { mode = [ "v" ]; key = "J"; action = ":m '>+1<CR>gv=gv"; }
        { mode = [ "v" ]; key = "K"; action = ":m '<-2<CR>gv=gv"; }

        { mode = [ "v" ]; key = "<leader>y"; action = "\"+y"; }
        { mode = [ "n" "v" ]; key = "<leader>d"; action = "_d"; }

        { mode = [ "n" ]; key = "<leader>x"; action = ":!chmod +x %<CR>"; }
        { mode = [ "n" ]; key = "<leader>X"; action = ":!chmod -x %<CR>"; }

        { mode = [ "n" ]; key = "<leader>R"; action = ":LspRestart<CR>"; }
        { mode = [ "n" ]; key = "gd"; action = ":Telescope lsp_definitions<CR>"; }
        { mode = [ "n" ]; key = "gr"; action = ":Telescope lsp_references<CR>"; }
        { mode = [ "n" ]; key = "<F2>"; action = ":lua vim.lsp.buf.rename()<CR>"; }
        { mode = [ "n" ]; key = "K"; action = ":Lspsaga hover_doc<CR>"; }
        { mode = [ "n" ]; key = "<leader>o"; action = ":Lspsaga outline<CR>"; }
        { mode = [ "n" ]; key = "<leader>ee"; action = ":Lspsaga show_line_diagnostics<CR>"; }
        { mode = [ "n" ]; key = "<leader>ej"; action = ":Lspsaga diagnostic_jump_next<CR>"; }
        { mode = [ "n" ]; key = "<leader>en"; action = ":Lspsaga diagnostic_jump_next<CR>"; }
        { mode = [ "n" ]; key = "<leader>ek"; action = ":Lspsaga diagnostic_jump_prev<CR>"; }
        { mode = [ "n" ]; key = "<leader>f"; action = ":lua require('conform').format { async = false }<CR>"; }
        { mode = [ "n" ]; key = "<leader>ss"; action = ":lua require('persistence').select()<CR>"; }

        { mode = [ "n" ]; key = "<leader>u"; action = ":UndotreeToggle<cr>"; }

        { mode = [ "n" ]; key = "<backspace>"; action = ":Oil<CR>"; }
    ];
}
