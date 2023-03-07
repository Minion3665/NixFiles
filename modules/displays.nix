{ lib, ... }: {
  config = {
    boot.kernelParams = [
      "video=eDP-1:2256x1440@60"
      "video=HDMI-A-1:3840x2160@76"
    ];
    services.xserver.config = lib.mkAfter ''
      Section "Device"
        Identifier "Device-radeon[1]"
        Driver     "ati" 
        BusID      "PCI:06:00.0"
        Option     "AllowExternalGpus" "True"
        Option     "AllowEmptyInitialConfiguration"
      EndSection
    '';
  };
  home.services.grobi = {
    enable = true;
    rules = [
      {
        name = "Docked";
        outputs_connected = [ "HDMI-A-1" "eDP-1" ];
        configure_column = [ "HDMI-A-1" "eDP-1" ];

        atomic = true;
        primary = "eDP-1";
      }
      {
        name = "Free";
        outputs_connected = [ "eDP-1" ];
        outputs_disconnected = [ "HDMI-A-1" ];
        configure_single = "eDP-1";
      }
      {
        name = "Fallback";
        configure_single = "eDP-1";
      }
    ];
  };
}
