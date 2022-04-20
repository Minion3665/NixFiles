{ pkgs, ... }: appimageTools.wrapType2 {
  name = "patchwork";
  src = ./oneshot-game/OneShot.AppImage;
  extraPkgs = pkgs: with pkgs; [ ];
}
