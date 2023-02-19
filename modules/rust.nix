{ username
, fenix
, system
, pkgs
, ...
}: {
  home.home.packages = with fenix.packages.${system}.latest; [
    cargo
    clippy
    rustc
    rustfmt
    pkgs.bacon
    pkgs.gcc
  ];
  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".cargo" ];
}
