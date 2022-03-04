{
    description = "Minion3665's NixFiles (since 2022-03-24)";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
        home-manager.url = "github:nix-community/home-manager/release-21.11";

        # Make sure flakes we depend on use the same version of nixpkgs as we do
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager }:
    let
        system = "x86_64-linux";  # TOOD: Add options for MacOS

        pkgs = import nixpkgs {
            inherit system;

            config = { allowUnfree = true; };
        };

        variables = import ./src/common/variables.nix;
    in {
        nixosConfigurations = {
            default = pkgs.lib.nixosSystem {
                inherit system;

                modules = [
                    src/system.nix
                ];
            };
        };

        homeManagerConfigurations = {
            minion = home-manager.lib.homeManagerConfiguration rec {
                inherit system pkgs;

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
