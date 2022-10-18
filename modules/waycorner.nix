{ pkgs, ... }:
let
  config = {
    left = {
      enter_command = [ ./systemd-inhibit/inhibit-idle.sh ];
      exit_command = [ ./systemd-inhibit/stop-inhibiting-idle.sh ];
      locations = [ "bottom_right" "bottom_left" ];
      size = 10;
      timeout_ms = 250;
    };
    "left.output".description = "";
  };
in
{
  home = {
    home = {
      packages = [ pkgs.waycorner ];
      file.".config/waycorner/config.toml".source = (pkgs.formats.toml { }).generate "config.toml" config;
    };
    wayland.windowManager.sway.config.startup = [
      { command = "${pkgs.waycorner}/bin/waycorner"; }
    ];
  };
}
