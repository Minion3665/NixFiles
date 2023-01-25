{ username
, fenix
, system
, pkgs
, ...
}: {
  home.home.packages = with fenix.packages.${system}.latest; [
    cargo
    rustc
    rustfmt
    rust-analyzer
    pkgs.bacon
    pkgs.gcc
  ];
  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".cargo" ];
}
