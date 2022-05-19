{ pkgs ? import <nixpkgs {} }:
pkgs.mkShell {
  buildInputs = [
    (import /home/minion/nix/shells/com.googlesource.android.partition-tools.platform.system.extras.nix)
  ]
}