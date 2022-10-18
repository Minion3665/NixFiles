{ pkgs
, home
, lib
, ...
}: {
  home = {
    home = {
      packages = [ pkgs.rofi-wayland ];
      file.".config/rofi/config.rasi".source = ./launcher/config.rasi;
    };
    wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
      "${home.wayland.windowManager.sway.config.modifier}+d" = "exec sh -c '${pkgs.procps}/bin/pkill rofi; ${pkgs.rofi-wayland}/bin/rofi -show combi'";
      "${home.wayland.windowManager.sway.config.modifier}+minus" = "exec sh -c '${pkgs.procps}/bin/pkill rofi; ${./launcher/show-scratchpad.sh}'";
    };
  };
}
