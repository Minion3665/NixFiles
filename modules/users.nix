{ pkgs
, config
, username
, ...
}: {
  config = {
    users.mutableUsers = false;

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "uinput" "input" "netdev" "wheel" "kvm" "docker" "containerd" "dialout" "libvirtd" "video" "tty" config.users.groups.keys.name ];
      shell = pkgs.zsh;
      passwordFile = config.sops.secrets.password.path;
    };
    users.users.root = {
      passwordFile = config.sops.secrets.password.path;
      # Important for physlock + sleep
    };

    environment.persistence."/large/persist".users.${username}.directories = [
      "Documents"
      "Pictures"
      "Code"
      "Programs"
    ];
    sops.secrets.password = {
      mode = "0400";
      neededForUsers = true;
    };
  };
}
