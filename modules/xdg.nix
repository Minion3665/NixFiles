{ pkgs, ... }: {
  home.home.packages = [ pkgs.xdg-utils ];
  config.xdg.portal = {
    enable = true;
    lxqt.enable = true;
  };
}
