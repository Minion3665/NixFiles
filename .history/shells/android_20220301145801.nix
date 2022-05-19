{ pkgs ? import <nixpkgs {} }:
pkgs.mkShell {
  buildInputs = [
    (import ./packages/)
  ]
}