{
  config = {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
      General.Experimental = true;
    };
    environment.persistence."/nix/persist".directories = [ "/var/lib/bluetooth" ];
  };
}
