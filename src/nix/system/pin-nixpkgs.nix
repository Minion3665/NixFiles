{ pkgs, ... }: {
  nix.registry.nixpkgs.flake = pkgs;
}