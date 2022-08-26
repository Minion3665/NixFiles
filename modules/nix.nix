{
  pkgs,
  registry,
  nixpkgs,
  ...
}: {
  config = {
    nix = {
      registry.nixpkgs.flake = nixpkgs;
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        keep-outputs = true;
        flake-registry = "${registry}/flake-registry.json";
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
      package = pkgs.nix;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.05"; # Did you read the comment?
  };

  home = {
    home.stateVersion = "22.05";
  };
}
