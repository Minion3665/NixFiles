{ pkgs ? import <nixpkgs {} }:
pkgs.mkShell {
  buildInputs = [
    (import /home/minion/nix/com.googlesource.android.partition-tools.platform.system.extras.nix)
  ]
}