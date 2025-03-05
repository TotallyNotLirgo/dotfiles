{ pkgs, ... }:
{
	enable = true;
	globals.mapleader = " ";
	globals.maplocalleader = " ";

        colorschemes.catppuccin.enable = true;
	plugins = {
		web-devicons.enable = true;
		lualine.enable = true;
		telescope = {
			enable = true;
			keymaps = {
				"<leader>sg" = "live_grep";
				"<leader>sf" = "find_files";
				"<leader>sr" = "resume";
			};
			extensions = {
				fzf-native.enable = true;
				ui-select.enable = true;
			};
		};
	};
}
