{
  pkgs,
  config,
  username,
  ...
}: {
  config = {
    users.mutableUsers = false;

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = ["wheel" "kvm" "docker" "containerd" "dialout" "libvirtd" "video" "tty" config.users.groups.keys.name];
      shell = pkgs.zsh;
      passwordFile = config.sops.secrets.password.path;
    };

    environment.persistence."/nix/persist".users.${username}.directories = ["Code" "Documents" "Pictures"];
    sops.secrets.password = {
      mode = "0400";
      neededForUsers = true;
    };
  };
}
