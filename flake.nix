{
  description = "Minion3665's NixFiles (@Python)";

  inputs = {
    # Set our release channels
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";

    # Make sure flakes we depend on use the same version of nixpkgs as we do
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    # Convert nixpkgs to pkgs
    pkgs = import nixpkgs {
      inherit system;

      config = { allowUnfree = true; };
    };

    # Nixpkgs helper functions
    lib = nixpkgs.lib;
  in {
    # Create a system config from our old config file
    nixosConfigurations = {
      python = lib.nixosSystem {
        inherit system;

        modules = [
          ./system/configuration.nix
        ];
      };
    };

    # This doesn't have to be called this; home-manager doesn't have a specified way to do this
    # This solution is from https://www.youtube.com/watch?v=mJbQ--iBc1U
    homeManagerConfigurations = {
      minion = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
	
        username = "minion";
	homeDirectory = "/home/minion";

        configuration = {
          imports = [
            ./users/minion/home.nix
          ];
        };

        stateVersion = "21.11";
      };
    };
  };
}
