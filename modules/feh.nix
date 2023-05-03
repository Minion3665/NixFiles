{ pkgs, ... }: {
  home.home = {
    packages = [ pkgs.feh ];
    file.".xmonad/background.png".source = ./feh/background.png;
  };
}
