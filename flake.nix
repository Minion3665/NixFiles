{
  description = "Minion's NixOS configuration (since 2022-08-19)";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.registry = {
    url = "github:nixos/flake-registry";
    flake = false;
  };

  outputs = inputs: let
    inherit (inputs) self nixpkgs flake-utils;
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      utils = import ./utils/utils.nix pkgs.lib;

      username = "minion";
    in {
      nixosConfigurations = {
        default = pkgs.lib.nixosSystem {
          inherit system;

          home-manager.useGlobalPkgs = true;

          modules = pkgs.lib.pipe ./modules [
            utils.nixFilesIn
            utils.importAll
            (utils.interpretNonstandardModule (args:
              args
              // {
                home =
                  args.config.home-manager."${username}";
              }))
          ];

          specialArgs = inputs // {inherit username;};
        };
      };
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [nodePackages.prettier alejandra];
        buildInputs = [];
      };
      formatter = pkgs.alejandra;
    });
}
