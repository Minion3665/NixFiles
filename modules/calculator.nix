{pkgs, ...}: let
  R = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      zoo
    ];
  };
in {
  home.home.packages = with pkgs; [wcalc R];
}
