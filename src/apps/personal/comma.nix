{ pkgs, ... }:
let
    comma = import ( pkgs.fetchFromGitHub {
        owner = "nix-community";
        repo = "comma";
        rev = "034a9ca440370fc1eccbed43ff345fb6ea1f0d27";
        sha256 = "sha256-WBIQmwlkb/GMoOq+Dnyrk8YmgiM/wJnc5HYZP8Uw72E=";
    }) {};
in {
    home.packages = [ comma ];
}
