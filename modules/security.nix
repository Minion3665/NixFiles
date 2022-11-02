{ lib
, pkgs
, config
, ...
}:
let
  lockMessage = "This computer has been locked, please authenticate to continue";
in
{
  config = {
    security.apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };

    boot.initrd.availableKernelModules = [
      "aesni_intel"
      "cryptd"
    ];

    boot.initrd.luks.devices = {
      nix.device = "/dev/disk/by-label/NIX";
      swap.device = "/dev/disk/by-label/SWAP";
      hdd.device = "/dev/disk/by-label/HDD";
    };

    services.physlock = {
      inherit lockMessage;
      enable = true;
      allowAnyUser = true;
    };
  };

  home =
    let
      lockCommand =
        lib.pipe ''
          ${pkgs.systemd}/bin/systemd-inhibit --why="Already locked" --what=idle --who="lock script" ${config.security.wrapperDir}/physlock -s -p "${lockMessage}"
        '' [
          (lib.splitString "\n")
          (lib.filter (line: line != ""))
          (lib.concatStringsSep " && ")
        ];
    in
    {
      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 60;
            command = lockCommand;
          }
        ];
      };
      home.packages = [
        (pkgs.writeScriptBin "lock" lockCommand)
      ];
    };
}
