{ pkgs, ... }: {
  home = {
    qt = {
      enable = true;
      platformTheme = "gnome";

      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };
    /* home.packages = [pkgs.adwaita-qt6]; */
  };
}
