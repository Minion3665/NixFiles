{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = [pkgs.nm-tray];
    networking.hostName = "python";
    networking.nameservers = ["1.1.1.1" "1.0.0.1"];

    services.resolved.enable = true;

    networking.useNetworkd = true;
    networking.dhcpcd.enable = false;
    systemd.network.enable = true;
    /*
    networking.networkmanager = {
    */
    /*
    enable = false;
    */
    /*
    wifi = {
    */
    /*
    backend = "iwd";
    */
    /*
    powersave = true;
    */
    /*
    };
    */
    /*
    appendNameservers = ["1.1.1.1" "1.0.0.1"];
    */
    /*
    };
    */

    /*
    networking.wireless.dbusControlled = true;
    */

    networking.wireless.iwd.enable = true;
    networking.wireless.iwd.settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
    networking.search = [
      "python.local"
    ];

    hardware.enableRedistributableFirmware = true;

    environment.persistence."/nix/persist".directories = ["/var/lib/iwd"];

    sops.secrets."eduroam.8021x" = {
      sopsFile = ../secrets/eduroam.8021x;
      format = "binary";
      path = "/var/lib/iwd/eduroam.8021x";
    };
    sops.secrets."eduroam.pem" = {
      sopsFile = ../secrets/eduroam.pem;
      format = "binary";
      path = "/var/lib/iwd/eduroam.pem";
    };

    systemd.services.systemd-networkd-wait-online.wantedBy = lib.mkForce [];
  };
}
