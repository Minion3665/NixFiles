{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    networking = {
      dhcpcd.extraConfig = ''
        timeout 0
        leasetime -1
        ipv6 off
        noipv6rs
        ipv4only
        noarp

        ssid eduroam
        static ip_address=10.0.48.79/8
        static routers=10.0.0.1
      '';
      hostName = "python";
      nameservers = ["1.1.1.1" "1.0.0.1"];
      search = [
        "python.local"
      ];
      wireless = {
        enable = true;
        userControlled.enable = true;
        networks = {
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
          "HRSFC Guest".psk = "@hrsfcGuestPass@";
          adelie10 = {
            psk = "@adelie10Pass@";
            priority = 500;
          };
          robocon-buster_beta.psk = "@roboconProtoboardPass@";
          "RoboCon2023-Sky".psk = "@robocon2023SkyPass@";
          "RoboCon2022-Beta_team_4".psk = "@robocon2023Beta4Pass@";
        };
        environmentFile = config.sops.secrets."wireless.env".path;
      };
    };

    hardware.enableRedistributableFirmware = true;

    sops.secrets."wireless.env" = {
      sopsFile = ../secrets/wireless.env.bin;
      format = "binary";
    };

    environment = {
      persistence."/nix/persist".directories = ["/var/db/dhcpcd"];
      systemPackages = [pkgs.bandwidth];
    };
  };
}
