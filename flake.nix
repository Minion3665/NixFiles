{
  description = "Minion's NixOS configuration (since 2022-08-19)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";
    nixpkgs-unfree.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-minion.url = "github:Minion3665/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    crane.url = "github:ipetkov/crane";
    vscode-extensions.url = "github:AmeerTaweel/nix-vscode-marketplace";
    registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    mommy = {
      url = "github:sudofox/shell-mommy/b4e9f50cecd4ebbf39f8c426315e2040c5623db7";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager";
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
    nps.url = "github:OleMussmann/Nix-Package-Search";
    lanzaboote.url = "github:nix-community/lanzaboote";

    fenix.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils-plus.inputs.flake-utils.follows = "flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nps.inputs.nixpkgs.follows = "nixpkgs";
    nps.inputs.flake-utils.follows = "flake-utils";
    crane.inputs.nixpkgs.follows = "nixpkgs";
    crane.inputs.flake-utils.follows = "flake-utils";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.flake-utils.follows = "flake-utils";
    lanzaboote.inputs.crane.follows = "crane";
  };

  outputs = inputs:
    let
      inherit (inputs) self nixpkgs flake-utils;
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = import ./overlays nixpkgs.lib (inputs // {
            inherit inputs
              username;
          });
        };

        utils = import ./utils pkgs;

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

        evalTrace = config: trace:
          let
            lib = nixpkgs.lib;
            splitTrace = lib.splitString "." trace;
            traceHead = builtins.head splitTrace;
            traceTail = builtins.tail splitTrace;
            resolvedTrace =
              (
                if traceHead == "home"
                then [ "home-manager" "users" username ]
                else lib.throwIfNot (traceHead == "config") ''You need to trace either home.** or config.** (found "${traceHead}" in "${trace}")'' [ ]
              )
              ++ traceTail;
          in
          (
            lib.pipe resolvedTrace [
              (lib.foldl
                ({ value
                 , error
                 ,
                 }: key:
                  if builtins.hasAttr key value
                  then {
                    value = value.${key};
                    inherit error;
                  }
                  else {
                    value = { };
                    error =
                      if error == false
                      then ''"${key}" does not exist in set "${builtins.toJSON value}"''
                      else error;
                  })
                {
                  value = config;
                  error = false;
                })
              (data: lib.warnIf (data.error != false) ''trace/${trace} is invalid; the key ${data.error}'' data)
              ({ value
               , error
               ,
               }: {
                value = builtins.toJSON value;
                inherit error;
              })
              ({ value
               , error
               ,
               }: {
                value = "trace/${trace}: ${value}";
                inherit error;
              })
              ({ value
               , error
               ,
               }:
                lib.warnIf (!error) value null)
            ]
          );
      in
      {
        packages = {
          nixosConfigurations =
            let
              nixosSystem = (nixpkgs.lib.nixosSystem
                {
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
                });
            in
            {
              default = builtins.deepSeq
                (map (evalTrace nixosSystem.config) nixosSystem.config.internal.traces)
                nixosSystem;
            };
        } // (import ./overlays/packages.nix
          { inherit (inputs) fenix crane; }
          pkgs
          pkgs);
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ nodePackages.prettier nixpkgs-fmt ];
          buildInputs = [ ];
        };
        formatter = pkgs.nixpkgs-fmt;
      });
}
