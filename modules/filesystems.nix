{impermanence, ...}: {
  imports = [
    impermanence.nixosModules.impermanence
  ];

  config = {
    environment.persistence."/nix/persist" = {
      hideMounts = true;
    };

    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=4G" "mode=755"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

    fileSystems."/nix" = {
      device = "/dev/mapper/nix";
      fsType = "ext4";
    };

    fileSystems."/large" = {
      device = "/dev/mapper/hdd";
      fsType = "ext4";
    };

    swapDevices = [
      {device = "/dev/mapper/swap";}
    ];
  };
}
