# Modified from http://chriswarbo.net/projects/nixos/useful_hacks.html
lib: dir: map (name: dir + "/${name}") (lib.attrNames (lib.filterAttrs (name: _: lib.hasSuffix ".nix" name) (builtins.readDir dir)))
