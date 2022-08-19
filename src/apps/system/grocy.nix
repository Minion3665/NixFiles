{ ... }: {
  services.grocy = {
    enable = true;

    settings = {
      currency = "GBP";
      culture = "en";
      calendar = {
        showWeekNumber = true;
        firstDayOfWeek = 0;
      };
    };

    hostName = "grocy.services.local";
    dataDir = "/var/lib/grocy";
    nginx.enableSSL = false; # must be false as we are hosting locally
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.hosts = {
    "127.0.0.1" = [ "grocy.services.local" ];
  };
}
