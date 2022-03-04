{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {

    home.packages = with pkgs; [

    ];  # Use *only* for packages that need no configuration; 
    # other packages should go in

    home.stateVersion = variables.stateVersion;
}