{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    (import /home/minion/Nix/shells/packages/com.googlesource.android.partition-tools.platform.system.extras.nix {inherit pkgs;})
  ];
}