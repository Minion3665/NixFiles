# Modified from http://chriswarbo.net/projects/nixos/useful_hacks.html
lib: dir: map (name: dir + "/${name}") (lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir)))
