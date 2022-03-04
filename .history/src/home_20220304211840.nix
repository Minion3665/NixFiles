{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {

    nixpkgs.overlays = [
        (import ./overlays/anytype.nix)
    ];

    home.packages = with pkgs; [
        anytype

            steam-tui steam-run
        minecraft
        git-crypt gnupg pinentry_qt
        spotify
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
        nodejs-17_x
        element
        tdesktop
    ];  # Use *only* for packages that need no configuration;
    # other packages should go in ./apps/personal/

    home.stateVersion = variables.stateVersion;
}