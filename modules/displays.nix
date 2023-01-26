{
  home.services.grobi = {
    enable = true;
    rules = [
      {
        name = "Docked";
        outputs_connected = [ "HDMI-1-0" "eDP-1" ];
        configure_column = [ "HDMI-1-0" "eDP-1" ];

        atomic = true;
        primary = "eDP-1";
      }
      {
        name = "Free";
        outputs_connected = [ "eDP-1" ];
        outputs_disconnected = [ "HDMI-1-0" ];
        configure_single = "eDP-1";
      }
      {
        name = "Fallback";
        configure_single = "eDP-1";
      }
    ];
  };
}
