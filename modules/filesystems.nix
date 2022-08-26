{impermanence, ...}: {
  imports = [
    impermanence.nixosModules.impermanence
  ];

  config = {
    environment.persistence."/nix/persist" = {
      hideMounts = true;
    };

    environment.persistence."/nix/cache" = {
      hideMounts = true;
    };

    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=20G" "mode=755"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

    fileSystems."/nix" = {
      device = "/dev/mapper/nix";
      fsType = "ext4";
      neededForBoot = true;
      options = ["noatime"];
    };

    fileSystems."/large" = {
      device = "/dev/mapper/hdd";
      fsType = "ext4";
    };

    swapDevices = [
      {device = "/dev/mapper/swap";}
    ];

    boot.initrd.availableKernelModules = ["nvme"];
  };
}
