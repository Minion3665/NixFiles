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
      extraGroups = ["wheel" "kvm" "docker" "containerd" "dialout" "libvirtd" "video" config.users.groups.keys.name];
      shell = pkgs.zsh;
    };

    users.users.root.initialPassword = "hunter2";
    # TODO: Change this as soon as we know the system boots properly and we make
    # user passwords persist
  };

  home.home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
}
