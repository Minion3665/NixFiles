{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  jdk8,
  jdk,
  zlib,
  file,
  wrapQtAppsHook,
  xorg,
  libpulseaudio,
  qtbase,
  libGL,
  quazip,
  glfw,
  openal,
  msaClientID ? "",
  jdks ? [jdk jdk8],
  extra-cmake-modules,
  tomlplusplus,
  ghc_filesystem,
  libnbtplusplus,
}: let
  rev = "243600b75babc636bdd1ac0dc8fd5fa4a2db1a0c";
  sha256 = "sha256-cDwa6NeZew+MubtRmUViLA8gUaoH3AMxD9PdQcgSgSU=";

  libnbtplusplus = fetchFromGitHub {
    owner = "ljfa-ag";
    repo = "libnbtplusplus";
    rev = "v2.5";
    sha256 = "sha256-4PHKPbWIWAy9ym25M4SnllTkrqnR+g/0AOqyMBZcdX4=";
  };
in
  stdenv.mkDerivation {
    pname = "prismlauncher";
    version = builtins.substring 0 7 rev;

    src = fetchFromGitHub {
      owner = "PlaceholderMC";
      repo = "PrismLauncher";
      inherit rev sha256;
    };

    postUnpack = ''
      rm -rf source/libraries/libnbtplusplus
      mkdir source/libraries/libnbtplusplus
      cp -a ${libnbtplusplus}/* source/libraries/libnbtplusplus
      chmod -R a+r+w source/libraries/libnbtplusplus
      chown -R $USER: source/libraries/libnbtplusplus
      ls source/libraries/libnbtplusplus/*
    '';

    nativeBuildInputs = [extra-cmake-modules tomlplusplus ghc_filesystem cmake file jdk wrapQtAppsHook];
    buildInputs = [qtbase zlib quazip];

    cmakeFlags = lib.optionals (msaClientID != "") ["-DLauncher_MSA_CLIENT_ID=${msaClientID}"];

    dontWrapQtApps = true;

    postInstall = let
      libpath = with xorg;
        lib.makeLibraryPath [
          libX11
          libXext
          libXcursor
          libXrandr
          libXxf86vm
          libpulseaudio
          libGL
          glfw
          openal
          stdenv.cc.cc.lib
        ];
    in ''
      # xorg.xrandr needed for LWJGL [2.9.2, 3) https://github.com/LWJGL/lwjgl/issues/128
      wrapQtApp $out/bin/prismlauncher \
        --set LD_LIBRARY_PATH /run/opengl-driver/lib:${libpath} \
        --prefix PRISMLAUNCHER_JAVA_PATHS : ${lib.makeSearchPath "bin/java" jdks} \
        --prefix PATH : ${lib.makeBinPath [xorg.xrandr]}
    '';

    meta = with lib; {
      homepage = "https://github.com/PlaceholderMC/PrismLauncher/";
      description = "A free, open source launcher for Minecraft";
      longDescription = ''
        Allows you to have multiple, separate instances of Minecraft (each with
        their own mods, texture packs, saves, etc) and helps you manage them and
        their associated options with a simple interface.
      '';
      platforms = platforms.linux;
      /*
      changelog = "https://github.com/PlaceholderMC/PrismLauncher/releases/tag/${version}";
      */
      license = licenses.gpl3Only;
      maintainers = with maintainers; [minion3665];
    };
  }
