{ pkgs, ... }: {
  config.services.clamav = {
    updater.enable = true;
    daemon.enable = true;
  };
  config.environment.systemPackages = [ pkgs.clamav ];
  config.environment.persistence."/large/persist" = "/var/lib/clamav";
}

