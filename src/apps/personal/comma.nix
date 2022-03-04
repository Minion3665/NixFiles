{ config, pkgs, nixpkgs, ... }:
let
    comma = import ( pkgs.fetchFromGitHub {
        owner = "nix-community";
        repo = "comma";
        rev = "02e3e5545b0c62595a77f3d5de1223c536af0614";
        sha256 = "sha256-WBIQmwlkb/GMoOq+Dnyrk8YmgiM/wJnc5HYZP8Uw72E=";
    }) {};
in {
    home.packages = [ comma ];
}