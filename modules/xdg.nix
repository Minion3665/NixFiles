{ pkgs, ... }: {
  home.home.packages = [ pkgs.xdg-utils ];
  config.xdg.portal.enable = false;
  # ^ portal is enabled in .xinitrc as this didn't work
}
