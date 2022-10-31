{pkgs, ...}: {
  config = {
    environment.systemPackages = [pkgs.gtklp];
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [foomatic-filters hplip cups-filters];
        browsing = true;
        browsedConf = ''
          BrowseDNSSDSubTypes _cups,_print
          BrowseLocalProtocols all
          BrowseRemoteProtocols all
          CreateIPPPrinterQueues All

          BrowseProtocols all
        '';
      };
    };

    environment.persistence."/nix/persist".directories = [
      "/var/spool/cups"
      "/etc/cups"
    ];
  };
}
