{ pkgs, ... }:

let
  callPackage = pkgs.lib.callPackageWith pkgs;

  lib = pkgs.lib;

  self = {
    anytype = callPackage ./anytype.nix { };
  };
in self
