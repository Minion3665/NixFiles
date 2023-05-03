pkgs_or_lib:
let
  is_pkgs = pkgs_or_lib ? lib;
  lib = if is_pkgs then pkgs_or_lib.lib else pkgs_or_lib;
  utils = lib.pipe ./. [
    (import ./nixFilesInWithName.nix lib)
    (builtins.map (file: rec {
      name = lib.removeSuffix ".nix" file.name;
      func = import file.path;
      accepts_pkgs = builtins.hasAttr "pkgs" (builtins.functionArgs func);
      value =
        if accepts_pkgs then
          func
            (builtins.intersectAttrs (builtins.functionArgs func) {
              inherit
                lib utils; pkgs = pkgs_or_lib;
            })
        else if is_pkgs
        then func lib
        else
          func pkgs_or_lib;
      include = file.name != "default.nix" && (!accepts_pkgs || is_pkgs);
    }))
    (builtins.filter (utility: utility.include))
    builtins.listToAttrs
  ];
in
utils
