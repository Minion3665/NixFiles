{
  pkgs,
  home,
  lib,
  ...
}: {
  home = {
    home = {
      packages = [pkgs.wofi];
      file.".config/wofi/config".source = ./launcher/config.toml;
    };
    wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
      "${home.wayland.windowManager.sway.config.modifier}+d" = "exec sh -c '${pkgs.procps}/bin/pkill wofi; ${pkgs.wofi}/bin/wofi'";
      "${home.wayland.windowManager.sway.config.modifier}+minus" = "exec sh -c '${pkgs.procps}/bin/pkill wofi; ${./launcher/show-scratchpad.sh}'";
    };
  };
}
