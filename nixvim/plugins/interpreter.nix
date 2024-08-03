let
    symbol_map = {
      Text = " ";
      Method = " ";
      Function = " ";
      Constructor = " ";
      Field = " ";
      Variable = " ";
      Class = " ";
      Interface = " ";
      Module = " ";
      Property = " ";
      Unit = " ";
      Value = " ";
      Enum = " ";
      Keyword = " ";
      Snippet = " ";
      Color = " ";
      File = " ";
      Reference = " ";
      Folder = " ";
      EnumMember = " ";
      Constant = " ";
      Struct = " ";
      Event = " ";
      Operator = " ";
      TypeParameter = " ";
    };
in
{
  lsp = {
    enable = true;
    servers = {
      pylsp = {
        enable = true;
        settings = {
          configurationSources = "flake8";
          plugins = {
            flake8.enabled = true;
            pycodestyle.enabled = false;
            pyflakes.enabled = false;
            black.enabled = true;
            isort.enabled = true;
          };
        };
      };
      lua-ls.enable = true;
    };
  };
  # lsp-format.enable = true;
  lsp-status.enable = true;

  treesitter = {
    enable = true;
    settings = {
      ensure_installed = "all";
      highlight.enable = true;
    };
  };
  lspkind = {
    enable = true;
    mode = "symbol";
    cmp.maxWidth = 50;
    symbolMap = symbol_map;
  };
  cmp = {
    enable = true;
    settings = {
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<C-Space>" = "cmp.mapping.complete()";
        "<Down>" = "cmp.mapping.select_next_item()";
        "<Up>" = "cmp.mapping.select_prev_item()";
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "buffer"; }
        { name = "path"; }
        { name = "treesitter"; }
      ];
      formatting.fields = [ "kind" "abbr" ];
    };
  };
  nix.enable = true;
}

