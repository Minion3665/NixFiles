let
  buildNumber = "54367901";
  sha = "sha256-kVM/F0LsIgMtur8jHZzUWkFIcfHe0i8y9Zxe3z5SkVM=";
in { pkgs ? import <nixpkgs> {} }:
pkgs.appimageTools.wrapType2 {
  name = "Anytype";
  version = buildNumber;
  src = pkgs.fetchurl {
    url = "https://download.anytype.io/?action=download&key=desktop&id=${buildNumber}";
    sha256 = sha;
    name = buildNumber + ".appimage";
  };

  extraPkgs = pkgs: with pkgs; [ libsecret xdg-desktop-portal hicolor-icon-theme ];
}
