lib:
lib.pipe ./. [
  (import ./nixFilesInWithName.nix lib)
  (builtins.map ({
    name,
    path,
  }: {
    name = lib.removeSuffix ".nix" name;
    value = import path lib;
  }))
  builtins.listToAttrs
]
