{
  description = "Minion's NixOS configuration (since 2022-08-19)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    sops-nix.url = "github:Mic92/sops-nix";
    impermanence.url = "github:nix-community/impermanence";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    inherit (inputs) self nixpkgs flake-utils;
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = import ./overlays nixpkgs.lib;
      };

      utils = import ./utils nixpkgs.lib;

      username = "minion";
    in {
      packages.nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            (nixpkgs.lib.pipe ./modules [
              utils.nixFilesIn
              (utils.interpretNonstandardModule (args:
                args
                // {
                  home = args.config.home-manager.users.${username};
                }))
            ])
            {
              minion = import ./config.nix;
            }
          ];

          specialArgs = inputs // {inherit username pkgs;};
        };
      };
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [nodePackages.prettier alejandra];
        buildInputs = [];
      };
      formatter = pkgs.alejandra;
    });
}
