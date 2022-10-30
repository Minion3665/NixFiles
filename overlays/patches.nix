final: prev: let
  lib = prev.lib;
  utils = import ../utils lib;
in
  lib.pipe ../patches [
    utils.dirsInWithName
    (builtins.map ({
      name,
      path,
    }: {
      inherit name;
      value = prev.${name}.overrideAttrs (prevAttrs: {
        patches =
          (prevAttrs.patches or [])
          ++ lib.traceValFn builtins.toJSON (lib.pipe path [
            builtins.readDir
            (lib.filterAttrs (_: type: type == "regular"))
            builtins.attrNames
            (builtins.map (name: "${path}/${name}"))
          ]);
      });
    }))
    builtins.listToAttrs
  ]
