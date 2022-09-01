{
  pkgs,
  lib,
  home,
  ...
}: {
  home = {
    home.packages = with pkgs; [grim slurp];

    wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
      "${home.wayland.windowManager.sway.config.modifier}+Shift+s" = "exec mkdir -p ~/Screenshots && grim -g \"$(slurp)\" - | tee ~/Screenshots/\"$(date --rfc-3339=seconds)\".png | wl-copy";
      "Print" = "exec mkdir -p ~/Screenshots && grim - | tee ~/Screenshots/\"$(date --rfc-3339=seconds)\".png | wl-copy";
    };
  };
}
