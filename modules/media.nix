{ pkgs, ... }: {
  home.home.packages = with pkgs; [ vlc syncplay ];
}
