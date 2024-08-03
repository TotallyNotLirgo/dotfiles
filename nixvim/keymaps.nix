{
    keymaps = [
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<F1>"; }

        # Quick movement
        { action = "10h"; mode = [ "n" "v" ]; key = "<C-h>"; }
        { action = "10j"; mode = [ "n" "v" ]; key = "<C-j>"; }
        { action = "10k"; mode = [ "n" "v" ]; key = "<C-k>"; }
        { action = "10l"; mode = [ "n" "v" ]; key = "<C-l>"; }

        # Unbinding mouse buttons
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<LeftMouse>"; }
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<RightMouse>"; }
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<MiddleMouse>"; }
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<2-LeftMouse>"; }
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<2-RightMouse>"; }
        { action = "<Nop>"; mode = [ "n" "v" "i" "t"]; key = "<2-MiddleMouse>"; }

        # Moving the selection
        { action = ":m '>+1<CR>gv=gv"; mode = [ "v" ]; key = "J"; }
        { action = ":m '>-2<CR>gv=gv"; mode = [ "v" ]; key = "K"; }

        # Clipboard shenanigans
        { action = "[[\"+y]]"; mode = [ "v" ]; key = "<leader>y"; options = { desc = "[Y]ank to system clipboard"; }; }
        { action = "[[_dP]]"; mode = [ "v" ]; key = "p"; options = { desc = "[P]aste without copying replaced"; }; }
        { action = "[[_d]]"; mode = [ "n" "v" ]; key = "<leader>d"; options = { desc = "[D]elete without copying"; }; }

        # Executable
        { action = ":!chmod +x %<CR>"; mode = [ "n" ]; key = "<leader>x"; options = { desc = "Make e[X]ecutable"; }; }
        { action = ":!chmod -x %<CR>"; mode = [ "n" ]; key = "<leader>X"; options = { desc = "Make not e[X]ecutable"; }; }

        # LSP
        { action = ":Lspsaga goto_definition<CR>"; mode = [ "n" ]; key = "gd"; options = { desc = "[G]o to [D]efinition"; }; }
        { action = ":Lspsaga peek_definition<CR>"; mode = [ "n" ]; key = "K"; }
    ];
}
