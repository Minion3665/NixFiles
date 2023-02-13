{ pkgs, ... }: {
  home.home.packages = with pkgs; [ zip unzip gnutar tarlz ];
}
