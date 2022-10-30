{pkgs, ...}: {
  config = {
    environment.systemPackages = [pkgs.gtklp];
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [hplip];
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
