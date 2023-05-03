{ pkgs, ... }: {
  home.home = {
    packages = [ pkgs.show ];
    file.".xmonad/wallpaper.glsl".source = ./wallpaper/wallpaper.glsl;
  };
}
