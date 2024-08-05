{
  description = "Home Manager configuration of emilia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-lazydev = {
      url = "github:folke/lazydev.nvim";
      flake = false;
    };
    nvim-luvit-meta = {
      url = "github:Bilal2453/luvit-meta";
      flake = false;
    };
    nvim-copilot = {
      url = "github:github/copilot.vim";
      flake = false;
    };
    nvim-ftFT = {
      url = "github:gukz/ftFT.nvim";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixpkgs.config.allowUnfree = true;
      home-manager.backupFileExtension = ".backup";
      homeConfigurations."emilia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
            ./home.nix
            ./spicetify.nix
        ];
      };
    };
}
