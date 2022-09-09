{config, ...}: {
  config = {
    networking.hostName = "python";
    networking.useDHCP = true;

    networking.wireless.iwd.enable = true;
    networking.wireless.iwd.settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Settings = {
        AutoConnect = true;
        AlwaysRandomizeAddress = true;
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
  };
}
