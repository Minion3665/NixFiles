{ pkgs, lib, ... }:
let
    variables = import ./common/variables.nix;
    personalPackages = import ./utils/nixFilesIn.nix lib ./apps/personal;
    overlays = import ./utils/nixFilesIn.nix lib ./apps/personal/overlays;
in {
    imports = personalPackages;

    nixpkgs.overlays = map (f: import f) overlays;

    home.packages = with pkgs; [  # New apps should be on new lines
        anytype
        minecraft
        nodejs-17_x

        git-crypt
        keepassxc
        grim slurp
        neovim helix
        qemu
        bind
        file
        nur.repos.kira-bruneau.rofi-wayland
        rofimoji
        htop
        hue-cli
        zip
        element
        tdesktop
    ];  # Use *only* for packages that need no configuration;
    # other packages should go in ./apps/personal/
}