{ pkgs, ... }: {
  config.nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://collabora.cachix.org"
      "https://nixfiles.cachix.org"
      "https://cache.nixos.org"
      "https://numtide.cachix.org"
    ];
    trusted-public-keys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "collabora.cachix.org-1:e5DYzGux57BzidOmwCJ7NJgydrumaTWtVXdswnerMoU="
      "nixfiles.cachix.org-1:QGVJNd+0aetjzU5l/MXrVg2adcrm9+8eL0HhIft3F+c="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
  home.home.packages = [ pkgs.cachix ];
}
