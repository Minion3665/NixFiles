final: prev:
let
  lib = prev.lib;
  utils = import ../utils lib;

  extraAttrSets = with final; [
    libsForQt5
    libsForQt5.qt5
  ];
in
lib.pipe ../packages [
  utils.nixFilesInWithName
  (map ({ name
        , path
        ,
        }: {
    name = builtins.substring 0 ((builtins.stringLength name) - 4) name;
    value = final.callPackage path (
      builtins.intersectAttrs
        (builtins.functionArgs (import path))
        (lib.fold lib.mergeAttrs { } extraAttrSets)
    );
  }))
  builtins.listToAttrs
]
