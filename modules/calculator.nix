{pkgs, ...}: let
  R = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      zoo
      ggvenn
      ggplot2
      RVenn
      networkD3
      shiny
    ];
  };
in {
  home.home.packages = with pkgs; [wcalc R kalgebra];
}
