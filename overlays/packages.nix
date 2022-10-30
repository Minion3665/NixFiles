final: prev: let
  lib = prev.lib;
  utils = import ../utils lib;
in
  lib.pipe ../packages [
    utils.nixFilesInWithName
    (map ({
      name,
      path,
    }: {
      name = builtins.substring 0 ((builtins.stringLength name) - 4) name;
      value = final.callPackage path {};
    }))
    builtins.listToAttrs
  ]
