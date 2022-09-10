{username, pkgs, ...}: {
  home.home.packages = with pkgs; [
    cargo
    clippy
    rustc
    rustfmt
    bacon
  ];
  config.environment.persistence."/nix/persist".users.${username}.directories = [".cargo"];
}
