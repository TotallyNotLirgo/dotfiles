{
  telescope = {
    enable = true;
    keymaps = {
      "<leader><space>" = { action = "buffers";    options = { desc = "[ ] Find existing buffers"; }; };
      "<leader>sf"      = { action = "find_files"; options = { desc = "[S]earch [F]iles"; }; };
      "<leader>sg"      = { action = "live_grep";  options = { desc = "[S]earch by [G]rep"; }; };
    };
  };
}
