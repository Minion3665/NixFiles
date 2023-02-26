{ lib, pkgs, home, config, utils, ... }: {
  home = {
    home.packages = with pkgs; [ xob pamixer ];
    xsession = {
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = utils.interpolateFile ./xmonad/xmonad.hs;
        libFiles = lib.pipe ./xmonad [
          builtins.readDir
          builtins.attrNames
          (builtins.filter (name: name != "xmonad.hs"))
          (map (name: {
            inherit name;
            value = utils.interpolateFile "${./xmonad}/${name}";
          }))
          builtins.listToAttrs
        ];
        extraPackages = haskellPackages: with haskellPackages; [
          dbus
          monad-logger
          xmonad-contrib
        ];
      };
    };
    programs.zsh.profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec ${pkgs.systemd}/bin/systemd-cat -t xmonad ${pkgs.xorg.xinit}/bin/startx
      fi
    '';
    home.file.".xinitrc".text = ''
      export XDG_DESKTOP_PORTAL_DIR=${pkgs.xdg-desktop-portal-gnome}/share/xdg-desktop-portal/portals
      ${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome &
      ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal &
      ${home.xsession.windowManager.command}
    '';
  };
  config.services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };
}
