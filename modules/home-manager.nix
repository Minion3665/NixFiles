{
  home-manager,
  lib,
  ...
}: {
  imports = [home-manager.nixosModules.home-manager];
  config = {
    home-manager.useGlobalPkgs = true;
    nixpkgs.overlays = import ../overlays lib;
  };
}
