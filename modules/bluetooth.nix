{
  config = {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
      General.Experimental = true;
    };
    environment.persistence."/nix/persist".directories = [ "/var/lib/bluetooth" ];
  };
  home = {
    home.file.".config/prelaunch/bluetooth-reconnect.sh".text = ''
      bluetoothctl connect E8:EE:CC:04:84:5F
    '';
    home.file.".config/prelaunch/bluetooth-reconnect.sh".executable = true;
  };
}
