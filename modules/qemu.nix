{
  home.home.shellAliases = {
    vm = "sudo nixos-rebuild build-vm --flake .#email";
    build = "sudo nixos-rebuild switch --flake .#default";
    build-nosub = "sudo nixos-rebuild switch --flake .#default --option substitute false";
  };
}
