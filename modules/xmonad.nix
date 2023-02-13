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
      ${home.xsession.windowManager.command}
    '';
  };
  config.services.xserver = {
    enable = true;
    layout = "gb";
    displayManager.startx.enable = true;
  };
}
