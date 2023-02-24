{ fenix, crane, nixpkgs-minion }: final: prev:
let
  lib = prev.lib;
  utils = import ../utils lib;

  extraAttrSets = with final; [
    libsForQt5
    libsForQt5.qt5
    qt6
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
        (lib.fold lib.mergeAttrs
          {
            packageSets = {
              minion = nixpkgs-minion.legacyPackages.${prev.system};
              fenix = fenix.packages.${prev.system};
            };
            _tooling = {
              inherit crane;
            };
          }
          extraAttrSets)
    );
  }))
  builtins.listToAttrs
]
