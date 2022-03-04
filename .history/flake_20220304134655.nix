{
    description = "Minion3665's NixFiles (since 2022-03-24)";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
        home-manager.url = "github:nix-community/home-manager/release-21.11";
    };

    outputs = { self, nixpkgs, home-manager }: {
        let
            system = "x86_64-linux";  # TOOD: Add options for MacOS

            pkgs = nixpkgs {
                inherit system;

                config = { allowUnfree = true; };
            };

            variables = import ./src/common/variables.nix;a
        in {
            nixosConfigurations = {
                default = pkgs.lib.nixosSystem {
                    inherit system;

                    modules = [
                        src/system.nix
                    ];
                }
            };

            homeManagerConfiguration = {
                minion = home-manager.lib.homeManagerConfiguration rec {
                    inherit system pkgs;

                    username = "minion";
                    homeDirectory = "/home/${username}";

                    configuration = {
                        imports = [
                            src/home.nix
                        ];
                    }

                    stateVersion = "21.11";
                }
            }
        };
    };
}
