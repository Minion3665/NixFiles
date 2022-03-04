{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {
    home.stateVersion = variables.stateVersion;

    home.packages = with pkgs; [
    ];
}