{ home-manager
, lib
, inputs
, username
, ...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  config = {
    home-manager.useGlobalPkgs = true;
    nixpkgs.overlays = import ../overlays lib (inputs // {
      inherit username inputs;
    });
  };
  home.home.activation.linkProfile = home-manager.lib.hm.dag.entryBefore [
    "installPackages"
  ] ''
    if [ ! -d /home/${username}/.nix-profile/ ]; then
      ln -s /nix/var/nix/profiles/per-user/${username}/profile/ /home/${username}/.nix-profile
    fi
  '';
}
