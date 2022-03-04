{ config, pkgs, nixpkgs }:
let
    variables = import ./common/variables.nix;
in {
    stateVersion = variables.stateVersion;

    home {
        packages = with pkgs; [

        ];
    }
}