{
  description = "Home Manager configuration of emily";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              system = prev.system;
            };
          })
        ];
      };
    in {
      nixosConfigurations = {
        bake-roll = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit pkgs; };
          modules = [ ./dotfiles/nixos/bake-roll/configuration.nix ];
        };
        chip = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit pkgs; };
          modules = [ ./dotfiles/nixos/chip/configuration.nix ];
        };
        popcorn = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit pkgs; };
          modules = [ ./dotfiles/nixos/popcorn/configuration.nix ];
        };
      };
      homeConfigurations."emily" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };
    };
}
