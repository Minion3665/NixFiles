{config, ...}: {
  config = {
    networking.hostName = "python";

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
  };
}
