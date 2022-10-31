lib: specialArgs:
let
  utils = import ../utils lib;
in
lib.pipe ./. [
  utils.nixFilesInWithName
  (builtins.filter ({ name, ... }: name != "default.nix"))
  (lib.traceValFn (overlays: "Applying overlays ${builtins.toJSON (map (overlay: overlay.name) overlays)}"))
  (builtins.map ({ path, ... }: lib.traceVal path))
  (map (path: import path))
  (map (overlay:
    if (builtins.functionArgs overlay) != { }
    then overlay (builtins.intersectAttrs (builtins.functionArgs overlay) specialArgs)
    else overlay))
]
