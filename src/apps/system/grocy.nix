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
    enableSSL = true;
  };
}
