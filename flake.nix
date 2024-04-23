{
  description = "Example Darwin system flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-plugins = {
      url = "github:LongerHV/neovim-plugins-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self
    , flake-utils
    , nixpkgs
    , nixpkgs-unstable
    , nix-darwin
    , home-manager
    , neovim-plugins
    }:
  let
    forAllSystems = nixpkgs.lib.genAttrs flake-utils.lib.defaultSystems;
    overlays = {
        unstable = final: prev: {
          unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          inherit (nixpkgs-unstable.legacyPackages.${prev.system}) neovim-unwrapped;
        };
        neovimPlugins = neovim-plugins.overlays.default;
    };

    legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues overlays;
        }
    );
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#eMacOS
    darwinConfigurations."macbookAir" = nix-darwin.lib.darwinSystem {
      pkgs = legacyPackages."aarch64-darwin";
      system = "aarch64-darwin";
      modules = [
        ./modules/nix-darwin/default.nix
        home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.iancleary = import ./modules/home-manager/default.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        
        ./home-manager/default.nix # myHome definition
      ];
      specialArgs = { inherit inputs; };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbookAir".pkgs;
  };
}
