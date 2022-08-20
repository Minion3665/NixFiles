{impermanence}: {
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
  };
}
