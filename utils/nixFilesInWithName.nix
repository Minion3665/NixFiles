# Modified from http://chriswarbo.net/projects/nixos/useful_hacks.html
lib: dir:
map
  (name: {
    inherit name;
    path = dir + "/${name}";
  })
  (lib.attrNames (lib.filterAttrs (name: type: lib.hasSuffix ".nix" name && type == "regular") (builtins.readDir dir)))
