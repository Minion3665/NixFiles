{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
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