{ username, config, ... }: {
  config = {
    hardware.opentabletdriver.enable = true;
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/OpenTabletDriver"
    ];
  };
  home = {
    home.file.".config/prelaunch/otd-daemon.sh".text = ''
      ${config.hardware.opentabletdriver.package}/bin/otd-daemon &
    '';
    home.file.".config/prelaunch/otd-daemon.sh".executable = true;
  };
}
