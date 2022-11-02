{ home-manager
, lib
, inputs
, username
, ...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  config = {
    home-manager.useGlobalPkgs = true;
    nixpkgs.overlays = import ../overlays lib (inputs // {
      inherit username inputs;
    });
  };
}
