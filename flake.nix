{
  description = "Minion's NixOS configuration (since 2022-08-19)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-minion.url = "github:Minion3665/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    vscode-extensions.url = "github:AmeerTaweel/nix-vscode-marketplace";
    registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager-unstable.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    impermanence.url = "github:nix-community/impermanence";
    gtimelog = {
      url = "git+https://gitlab.collabora.com/collabora/gtimelog.git";
      flake = false;
    };
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
    omnisharp-language-server = {
      url = "github:coc-extensions/coc-omnisharp";
      flake = false;
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix.url = "github:nix-community/fenix";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    fenix.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils-plus.inputs.flake-utils.follows = "flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      inherit (inputs) self nixpkgs flake-utils;
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = import ./overlays nixpkgs.lib (inputs // { inherit inputs
          username; });
        };

        utils = import ./utils nixpkgs.lib;

        username = "minion";

        isAttrType = type:
          if builtins.elem type.name [ "submodule" ]
          then true
          else if type ? nestedTypes.elemType
          then isAttrType type.nestedTypes.elemType
          else false;

        normalizeOptions = options:
          if
            nixpkgs.lib.traceSeqN 2
              {
                inherit options;
                type = builtins.typeOf options;
              }
              builtins.typeOf
              options
            == "set"
          then
            nixpkgs.lib.mapAttrs
              (
                name: value:
                  if
                    nixpkgs.lib.traceSeqN 3
                      {
                        inherit name value;
                        hasGetSubOpts = value ? getSubOptions;
                        hasType = value ? type;
                        isAttrType = value ? type && isAttrType value.type;
                        typeName = value.type.name or "unnamed";
                        type = builtins.typeOf value;
                      }
                      (builtins.typeOf value)
                    == "set"
                  then
                    nixpkgs.lib.traceVal
                      (normalizeOptions (
                        if value ? type && isAttrType value.type
                        then nixpkgs.lib.traceVal (value.type.getSubOptions [ ])
                        else nixpkgs.lib.traceVal value
                      ))
                  else value
              )
              options
          else options;
      in
      {
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
                    home-options =
                      nixpkgs.lib.traceVal (normalizeOptions
                        (args.options.home-manager.users.type.getSubOptions [ ]));
                    inherit system utils;
                  }))
              ])
              {
                minion = import ./config.nix;
              }
            ];

            specialArgs = inputs // { inherit inputs username; };
          };
        };
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ nodePackages.prettier nixpkgs-fmt ];
          buildInputs = [ ];
        };
        formatter = pkgs.nixpkgs-fmt;
      });
}
