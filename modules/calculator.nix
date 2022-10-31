{pkgs, ...}: let
  R = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      zoo
      ggvenn
      ggplot2
      RVenn
    ];
  };
in {
  home.home.packages = with pkgs; [wcalc R];
}
