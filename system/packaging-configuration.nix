{ config, pkgs, options, ... }: {
  # Apply custom packaging overlays for compatability
  nix.nixPath =
    # Prepend default nixPath values.
    options.nix.nixPath.default ++
    # Append our nixpkgs-overlays.
    [ "nixpkgs-overlays=/etc/nixos/overlays/" ]
  ;
}
