{ lib, pkgs, ... }: {
  config.boot.kernelParams = [
    "video=eDP-1:2256x1504@60"
    "video=HDMI-1-1:1920x1080@144"
    "video=DP-1-3:3840x2160@76"
  ];
  home = {
    services.grobi = {
      enable = true;
      rules = (map
        (output: {
          name = "Docked (${output})";
          outputs_connected = [ output "eDP-1" ];
          configure_command = "xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x1454 --rotate normal --output ${output} --mode 3840x2160 --pos 2256x0 --rotate normal";
          atomic = true;
          primary = "eDP-1";
        })
        ([ "HDMI-A-1" "HDMI-A-1-0" ] ++
          (map (num: "DP-" + toString num) (lib.range 1 8))
        )) ++ [
        {
          name = "Docked (HDMI-1-1 + DP-1-3)";
          outputs_connected = [ "HDMI-1-1" "eDP-1" "DP-1-3" ];
          configure_command = "xrandr --output HDMI-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 2256x1504 --pos 0x1454 --rotate normal --output DP-1-3 --mode 3840x2160 --pos 2256x0 --rotate normal";
          atomic = true;
          primary = "eDP-1";
        }
        {
          name = "Free";
          outputs_connected = [ "eDP-1" ];
          outputs_disconnected = [ "HDMI-A-1" "HDMI-1-1" "DP-1-3" ];
          configure_single = "eDP-1";
        }
        {
          name = "Fallback";
          configure_single = "eDP-1";
        }
      ];
    };

    home.file.".config/prelaunch/displays.sh".text = ''
      ${pkgs.grobi}/bin/grobi watch -v
    '';
    home.file.".config/prelaunch/displays.sh".executable = true;
    systemd.user.services.grobi.Install.WantedBy = lib.mkForce [ ];
  };
}
