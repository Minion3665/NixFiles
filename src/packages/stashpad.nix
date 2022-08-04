{ pkgs, ... }: pkgs.appimageTools.wrapType1 {
  name = "StashPad";
  src = "./stashpad/StashPad.AppImage";
  extraPkgs = pkgs: with pkgs; [ ];
}
