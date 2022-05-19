let
  version = "51995916";
  buildNumber = "51995916";
in { pkgs ? import <nixpkgs> {} }:
pkgs.appimageTools.wrapType2 {
  name = "Anytype";
  version = version;
  src = pkgs.fetchurl {
    url = "https://download.anytype.io/?action=download&key=desktop&id=51995916";
    sha256 = "sha256-28qgTWCQrFCREGNfj8bePocEpB+0AZfrKNO4akn7/5I=";
    name = version + ".appimage";
  };

  extraPkgs = pkgs: with pkgs; [ libsecret xdg-desktop-portal hicolor-icon-theme ];
}
