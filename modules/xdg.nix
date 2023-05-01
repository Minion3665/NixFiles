{ pkgs, ... }: {
  home.home.packages = [ pkgs.xdg-utils pkgs.xdg-user-dirs ];
  config.xdg.portal.enable = false;
  # ^ portal is enabled in .xinitrc as this didn't work
}
