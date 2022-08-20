{pkgs, ...}: {
  users.mutableUsers = false;

  users.users.minion = {
    isNormalUser = true;
    extraGroups = ["wheel" "kvm" "docker" "containerd" "dialout" "libvirtd" "video" config.users.groups.keys.name];
    shell = pkgs.zsh;
  };

  users.users.root.initialPassword = "hunter2";
  # TODO: Change this as soon as we know the system boots properly and we make
  # user passwords persist
}
