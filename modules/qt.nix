{pkgs, ...}: {
  home.qt = {
    enable = true;
    platformTheme = "gtk";

    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
