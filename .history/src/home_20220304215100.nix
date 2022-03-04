{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
    personalPackages = let
      toPkg = file: {
        name = builtins.replaceStrings [ ".nix" ] [ "" ] file;
        value = import (./. + "/pkgConfigs/${file}") { };
       };
     in
       pkgs.lib.mapAttrs' toPkg (builtins.readDir (./. + "/pkgConfigs"));

in {
    import = [
        ./apps/personal/steam.nix

    ];

    nixpkgs.overlays = [
        (import ./overlays/anytype.nix)
    ];

    home.packages = with pkgs; [  # New apps should be on new lines
        anytype
        minecraft
        nodejs-17_x

        git-crypt gnupg pinentry_qt
        keepassxc
        grim slurp
        neovim helix
        qemu
        bind
        file
        nur.repos.kira-bruneau.rofi-wayland
        rofimoji
        anytype-latest
        htop
        hue-cli
        comma
        zip
        mindustry-alpha-wayland
        element
        tdesktop
    ];  # Use *only* for packages that need no configuration;
    # other packages should go in ./apps/personal/

    home.stateVersion = variables.stateVersion;
}