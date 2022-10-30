{pkgs, ...}: {
  home.home.packages = with pkgs; [wcalc R];
}
