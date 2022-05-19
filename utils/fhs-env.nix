{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "fhs";
  targetPkgs = pkgs: with pkgs; [
    coreutils
  ];
  multiPkgs = pkgs: with pkgs; [
    zlib
    xorg.libXxf86vm
    curl
    openal
    openssl
    dict
    xorg.libXext
    xorg.libX11
    xorg.libXrandr
    mesa_glu
  ];
  runScript = "bash";
}).env
