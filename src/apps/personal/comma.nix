{ pkgs, ... }:
let
    comma = (import ( pkgs.fetchFromGitHub {
        owner = "nix-community";
        repo = "comma";
        rev = "034a9ca440370fc1eccbed43ff345fb6ea1f0d27";
        sha256 = "sha256-CZQLigKovJbMoTbPuWT3SBSMymjD58m72O/oy+HilQg=";
    })).default;
in {
    home.packages = [ comma ];
}
