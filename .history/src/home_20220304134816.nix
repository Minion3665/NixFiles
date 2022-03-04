{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {

    home.packages = with pkgs; [
    ];

    home.stateVersion = variables.stateVersion;
}