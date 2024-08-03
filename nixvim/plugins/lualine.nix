{
  lualine = {
    enable = true;
    theme = "onedark";
    sections = {
        lualine_b = [ "diagnostics" ];
        lualine_c = [ {name="filename"; extraConfig = {path = 1;};} ];
        lualine_x = [ "filetype" ];
        lualine_y = [ ];
        lualine_z = [ "location" ];
    };
    extensions = [ "nvim-tree" ];
  };
}
