{ pkgs, ... }: {
  config.hardware.openrazer = {
    enable = true;
    users = [ "minion" ];
  };

  home.home.packages = [ pkgs.razergenie ];
}
