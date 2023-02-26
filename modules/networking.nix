{ config
, lib
, pkgs
, ...
}: {
  config = {
    networking = {
      dhcpcd = {
        wait = "background";
        extraConfig = ''
          timeout 0
          leasetime -1
          ipv6 off
          noipv6rs
          ipv4only
          noarp

          ssid HRSFC Guest
          static ip_address=10.0.48.79/8
          static routers=10.0.0.1

          ssid eduroam
          static ip_address=10.0.48.79/8
          static routers=10.0.0.1
        '';
      };
      hostName = "python";
      nameservers = [ "1.1.1.1" "1.0.0.1" ];
      search = [
        "python.local"
      ];
      wireless = {
        enable = true;
        userControlled.enable = true;
        networks = {
          "HRSFC-LAN".psk = "@hrsfcStaffPass@";
          eduroam = {
            auth = ''
              scan_ssid=1
              proto=WPA2
              key_mgmt=WPA-EAP
              eap=PEAP
              pairwise=CCMP

              identity="@eduroamUser@"
              password="@eduroamPass@"

              phase2="auth=MSCHAPV2"
            '';
          };
          "HRSFC Wi-Fi".psk = "@hrsfcGuestPass@";
          adelie10 = {
            psk = "@adelie10Pass@";
            priority = 500;
          };
          robocon-buster_beta.psk = "@roboconProtoboardPass@";
          "RoboCon3665-Sky".psk = "@robocon3665SkyPass@";
          "RoboCon2022-Beta_team_4".psk = "@robocon2023Beta4Pass@";
          "RoboCon2023-Will".psk = "@robocon2023Will@";
          "robot-HRS69420".psk = "@srRobotPassword@";
          "newadelie24".psk = "@newadelie24Pass@";
        } // lib.pipe (lib.range 1 21) [
          (builtins.map builtins.toString)
          (builtins.map (team: {
            name = "RoboCon2023-Team${team}";
            value = {
              psk = "@robocon2023Team${team}@";
            };
          }))
          builtins.listToAttrs
        ];
        environmentFile = config.sops.secrets."wireless.env".path;
      };
    };

    hardware.enableRedistributableFirmware = true;

    sops.secrets."wireless.env" = {
      sopsFile = ../secrets/wireless.env.bin;
      format = "binary";
    };

    environment = {
      persistence."/nix/persist".directories = [ "/var/db/dhcpcd" ];
      systemPackages = [ pkgs.bandwidth ];
    };
  };
}
