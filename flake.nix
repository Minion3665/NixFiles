{
    description = "Minion3665's NixFiles (since 2022-03-24)";

    inputs = {
        registry = {
            url = "github:nixos/flake-registry";
            flake = false;
        };
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-21-11.url = "github:nixos/nixpkgs/nixos-21.11";
        home-manager.url = "github:nix-community/home-manager/release-22.05";
        nurpkgs.url = "github:nix-community/NUR";
        comma.url = "github:nix-community/comma";
        nixpkgs-minion.url = "github:minion3665/nixpkgs";
        fzf-tab = {
            url = "github:Aloxaf/fzf-tab";
            flake = false;
        };
        git-confirm = {
            url = "github:pimterry/git-confirm";
            flake = false;
        };
        vim-ctrlspace = {
            url = "github:vim-ctrlspace/vim-ctrlspace";
            flake = false;
        };
        sops-nix.url = "github:Mic92/sops-nix";

        # Make sure flakes we depend on use the same version of nixpkgs as we do
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = extraInputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-21-11, nixpkgs-minion, home-manager, ... }:
    let
        system = "x86_64-linux";  # TOOD: Add options for MacOS

        unstable-overlays = import ./src/utils/nixFilesIn.nix nixpkgs-unstable.lib ./src/unstable-overlays;

        pkgs = import nixpkgs {
            inherit system;

            config = { allowUnfree = true; };
        };

        pkgs-unstable = import nixpkgs-unstable {
            inherit system;

            overlays = map (f: import f) unstable-overlays;
            config = { allowUnfree = true; };
        };

        pkgs-21-11 = import nixpkgs-21-11 {
            inherit system;

            config = { allowUnfree = true; };
        };

        pkgs-minion = import nixpkgs-minion {
            inherit system;

            config = { allowUnfree = true; };
        };

        variables = import ./src/common/variables.nix;
    in {
        nixosConfigurations = {
            default = nixpkgs.lib.nixosSystem {
                inherit system;

                specialArgs = extraInputs // {
                  inherit nixpkgs nixpkgs-unstable home-manager pkgs-unstable pkgs-21-11 pkgs-minion system;
                };

                modules = [
                    src/system.nix
                    extraInputs.sops-nix.nixosModules.sops
                ];
            };
        };

        homeConfigurations = {
            "${variables.username}" = home-manager.lib.homeManagerConfiguration rec {
                inherit system pkgs;

                extraSpecialArgs = extraInputs // { inherit nixpkgs nixpkgs-unstable home-manager pkgs-unstable pkgs-21-11 pkgs-minion system; };

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
