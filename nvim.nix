{ pkgs, ... }:
{
  enable = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  extraLuaConfig = ''
    ${builtins.readFile ./nvim/settings.lua}
    ${builtins.readFile ./nvim/keymaps.lua}
    ${builtins.readFile ./nvim/autocommands.lua}

    ${builtins.readFile ./nvim/plugins/which-key.lua}
    ${builtins.readFile ./nvim/plugins/theme.lua}
    ${builtins.readFile ./nvim/plugins/telescope.lua}
    ${builtins.readFile ./nvim/plugins/nvim-tree.lua}
    ${builtins.readFile ./nvim/plugins/misc.lua}
    ${builtins.readFile ./nvim/plugins/lualine.lua}
    ${builtins.readFile ./nvim/plugins/gitsigns.lua}
    ${builtins.readFile ./nvim/plugins/lsp/treesitter.lua}
    ${builtins.readFile ./nvim/plugins/lsp/lspconfig.lua}
    ${builtins.readFile ./nvim/plugins/lsp/lspsaga.lua}
    ${builtins.readFile ./nvim/plugins/lsp/cmp.lua}
    ${builtins.readFile ./nvim/plugins/lsp/autoformat.lua}
  '';

  plugins = with pkgs.vimPlugins; [
    which-key-nvim
    onedark-nvim
    telescope-nvim
    telescope-ui-select-nvim
    nvim-web-devicons
    plenary-nvim
    nvim-tree-lua
    vim-sleuth
    nvim-autopairs
    indent-blankline-nvim
    auto-save-nvim
    lualine-nvim
    gitsigns-nvim
    nvim-lspconfig
    fidget-nvim
    cmp-nvim-lsp
    nvim-cmp
    cmp-path
    lspkind-nvim
    conform-nvim
    lspsaga-nvim
    (
      nvim-treesitter.withPlugins (p: with p; [
        tree-sitter-nix
        tree-sitter-vim
        tree-sitter-bash
        tree-sitter-lua
        tree-sitter-python
        tree-sitter-json
      ])
    )
    git-lazydev
    git-luvit-meta
    git-copilot
  ];
  extraPackages = with pkgs; [
    sumneko-lua-language-server
    python311Packages.python-lsp-server
    python311Packages.black
    python311Packages.isort
    python311Packages.docformatter
    nixd
  ];
}
