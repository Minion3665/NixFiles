{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    networking = {
      hostName = "python";
      nameservers = ["1.1.1.1" "1.0.0.1"];
      /* networkmanager = { */
      /*   enable = true; */
      /*   wifi.powersave = true; */
      /*   insertNameservers = ["1.1.1.1" "1.0.0.1"]; */
      /*   firewallBackend = "nftables"; */
      /*   unmanaged = ["*"]; */
      /* }; */
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
        };
        environmentFile = config.sops.secrets."wireless.env".path;
      };
    };

    hardware.enableRedistributableFirmware = true;

    sops.secrets."wireless.env" = {
      sopsFile = ../secrets/wireless.env.bin;
      format = "binary";
    };
  };
}
