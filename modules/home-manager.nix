{home-manager, ...}: {
  imports = [home-manager.nixosModules.home-manager];
  config.home-manager.useGlobalPkgs = true;
}
