{ pkgs, ... }: {
  home.home = {
    packages = with pkgs; [ gsettings-desktop-schemas glib ];
    sessionVariables = {
      XDG_DATA_DIRS =
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:${pkgs.hybridbar}/share/gsettings-schemas/${pkgs.hybridbar.name}:$XDG_DATA_DIRS";
    };
  };
}
