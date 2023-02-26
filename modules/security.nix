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
    services.fprintd.enable = true;

    security.apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };

    boot.initrd.availableKernelModules = [
      "aesni_intel"
      "cryptd"
      "uas"
      "xhci_hcd"
    ];

    boot.initrd.luks.devices = {
      nix.device = "/dev/disk/by-label/NIX";
      swap.device = "/dev/disk/by-label/SWAP";
      expansion0.device = "/dev/disk/by-label/EXPANSION0";
    };

    services.physlock = {
      inherit lockMessage;
      enable = false;
      allowAnyUser = true;
    };

    security.wrappers = {
      lock = {
        source = ./security/lock.sh;
        setuid = true;
        owner = config.users.users.root.name;
        group = config.users.users.nobody.group;
      };
      _onLock = {
        source = ./security/onLock.sh;
        setuid = false;
        owner = config.users.users.root.name;
        group = config.users.users.nobody.group;
      };
    };
  };

  home =
    let
      lockCommand =
        lib.pipe ''
          ${pkgs.systemd}/bin/systemd-inhibit --why="Already locked" --what=idle --who="lock script" ${config.security.wrapperDir}/lock
        '' [
          (lib.splitString "\n")
          (lib.filter (line: line != ""))
          (lib.concatStringsSep " && ")
        ];
    in
    {
      services.swayidle = {
        enable = false;
        timeouts = [
          {
            timeout = 60;
            command = lockCommand;
          }
        ];
      };
      home.packages = [
        (pkgs.writeScriptBin "lock" lockCommand)
        pkgs.kbd
      ];
    };
}
