{ home-manager
, lib
, inputs
, username
, prismlauncher
, ...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  config = {
    home-manager.useGlobalPkgs = true;
    nixpkgs.overlays = import ../overlays lib (inputs // {
      inherit username inputs;
    }) ++ [ prismlauncher.overlay ];
  };
}
