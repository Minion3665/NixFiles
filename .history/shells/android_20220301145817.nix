{ pkgs ? import <nixpkgs {} }:
pkgs.mkShell {
  buildInputs = [
    (import com.googlesource.android.partition-tools.platform.system.extras.nix)
  ]
}