lib:
builtins.listToAttrs builtins.map (path: {
  name = nixpkgs.lib.pipe path [
    (nixpkgs.lib.removeSuffix ".nix")
    (nixpkgs.lib.removePrefix ./.)
  ];
  value = import path;
}) ((import ./nixFilesIn.nix) ./.)
