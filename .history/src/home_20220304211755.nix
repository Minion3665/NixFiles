{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {

    nixpkgs.overlays = [
        (import ./overlays/anytype.nix)
    ];

    home.packages = with pkgs; [
        anytype
    ];  # Use *only* for packages that need no configuration;
    # other packages should go in ./apps/personal/

    home.stateVersion = variables.stateVersion;
}