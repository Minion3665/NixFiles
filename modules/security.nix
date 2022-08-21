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
      nix.device = "/dev/disk/by-label/nix";
      swap.device = "/dev/disk/by-label/swap";
      hdd.device = "/dev/disk/by-label/hdd";
  };
}
