{ pkgs, ... }: {
  home.home = {
    packages = [ pkgs.xorg.xmodmap ];
    file.".Xmodmap".text = ''
      keycode 66 = F12
      clear Lock
    '';
  };
}
