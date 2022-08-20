{
  config = {
    networking.hostName = "python";

    networking.wireless.iwd.enable = true;
    networking.wireless.iwd.settings = {
      Settings = {
        AutoConnect = true;
        AlwaysRandomizeAddress = true;
      };
    };
    networking.search = [
      "python.local"
    ];
  };
}
