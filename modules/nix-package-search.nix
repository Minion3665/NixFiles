{ nps, system, username, ... }: {
  config.environment.persistence."/nix/persist".users.${username}.directories =
    [ ".nix-package-search" ];
  home.home.packages = [ nps.defaultPackage.${system} ];
}
