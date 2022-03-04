{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {

    nixpkgs.overlays = [
        (import ./overlays/anytype.nix)
        (import ./overlays/mindustry.nix)
        (import ./overlays/nur.nix)
    ];

    home.packages = with pkgs; [

    ];  # Use *only* for packages that need no configuration;
    # other packages should go in ./apps/personal/

    home.stateVersion = variables.stateVersion;
}