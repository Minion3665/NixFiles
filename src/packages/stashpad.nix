{ pkgs, ... }: pkgs.appimageTools.wrapType1 {
  name = "ShashPad";
  src = "./shashpad/ShashPad.AppImage";
  extraPkgs = pkgs: with pkgs; [ ];
}
