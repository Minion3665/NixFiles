{
    description = "Minion3665's NixFiles (since 2022-03-24)";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-mongodb-fix.url = "github:Et7f3/nixpkgs/fix-mongodb";
        home-manager.url = "github:nix-community/home-manager/release-22.05";
        nurpkgs.url = "github:nix-community/NUR";
        comma.url = "github:nix-community/comma";

        # Make sure flakes we depend on use the same version of nixpkgs as we do
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = extraInputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
        system = "x86_64-linux";  # TOOD: Add options for MacOS

        pkgs = import nixpkgs {
            inherit system;

            config = { allowUnfree = true; };
        };

        pkgs-unstable = import nixpkgs-unstable {
            inherit system;

            config = { allowUnfree = true; };
        };

        variables = import ./src/common/variables.nix;
    in {
        nixosConfigurations = {
            default = nixpkgs.lib.nixosSystem {
                inherit system;

                specialArgs = extraInputs // {
                  inherit nixpkgs system;
                };

                modules = [
                    src/system.nix
                ];
            };
        };

        homeConfigurations = {
            "${variables.username}" = home-manager.lib.homeManagerConfiguration rec {
                inherit system pkgs;

                extraSpecialArgs = extraInputs // { inherit pkgs-unstable system; };

                username = variables.username;
                homeDirectory = "/home/${username}";
                stateVersion = variables.stateVersion;

                configuration = {
                    imports = [
                        src/home.nix
                    ];

                    programs.home-manager.enable = true;
                    # Although I don't do any other configuration here directly,
                    # this is needed to make home-manager work and so *must* be
                    # present on every home manager configuration.
                };
            };
        };
    };
}
