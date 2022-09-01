{pkgs, ...}: {
  config = {
    services = {
      printing = {
        enable = true;
        drivers = [pkgs.hplip];
      };

      avahi = {
        enable = true;
        nssmdns = true;
      };
    };

    environment.persistence."/nix/persist".directories = [
      "/var/spool/cups"
      "/etc/cups"
    ];
  };
}
