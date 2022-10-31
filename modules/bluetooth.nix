{
  config = {
    hardware.bluetooth.enable = true;
    environment.persistence."/nix/persist".directories = [ "/var/lib/bluetooth" ];
  };
}
