{
  home.home.shellAliases = {
    vm = "sudo nixos-rebuild build-vm --flake .#email";
    build = "nice -n 19 sudo nixos-rebuild switch --flake .#default";
    build-nosub = "nice -n 19 sudo nixos-rebuild switch --flake .#default --option substitute false";
    mnt = "sudo mkdir /mnt -p && sudo mount --target /mnt";
  };
}
