{ pkgs, ... }: pkgs.appimageTools.wrapType1 {
  name = "OneShot";
  src = "./oneshot-game/OneShot.AppImage";
  extraPkgs = pkgs: with pkgs; [ ];
}
