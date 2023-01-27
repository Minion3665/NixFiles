{ username
, fenix
, system
, pkgs
, ...
}: {
  home.home.packages = [
    fenix.packages.${system}.latest.toolchain
    pkgs.bacon
    pkgs.gcc
  ];
  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".cargo" ];
}
