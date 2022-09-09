{pkgs, ...}: {
  config = {
    services.tlp.enable = true;

    powerManagement.powertop.enable = true;

    environment = {
      systemPackages = [pkgs.powertop];
      persistence."/nix/persist".directories = ["/var/cache/powertop"];
    };
  };
}
