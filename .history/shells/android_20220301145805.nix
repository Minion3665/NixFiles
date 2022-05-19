{ pkgs ? import <nixpkgs {} }:
pkgs.mkShell {
  buildInputs = [
    (import ./packages/com.googlesource.android.)
  ]
}