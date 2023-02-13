{ pkgs, utils }:
let
  lib = pkgs.lib;
in
file: lib.pipe file [
  builtins.readFile
  (builtins.split "\\\$\\{\\{([^}]*)}}")
  (map (part:
    if builtins.typeOf part == "string"
    then part
    else
      import
        (
          (
            pkgs.writeText "generated.nix" ("pkgs: lib: " + (builtins.elemAt part 0))
          ).outPath
        )
        pkgs
        lib
  ))
  (map (part:
    if builtins.typeOf part == "string" then part
    else if builtins.typeOf part == "path" then
      let
        stringified = toString part;
      in
      builtins.toString (utils.interpolateFile (
        file + "/.." + (builtins.substring
          (builtins.stringLength "/nix/store")
          (builtins.stringLength
            stringified)
          stringified)
        # ^ Somewhat of a hack, works because we know that the file path
        # is a text file (i.e. not a directory) as we read it earlier and
        # relative paths end up in /nix/store due to the writeText. Absolute
        # paths are not supported
      ))
    else
      toString part
  ))
  (builtins.concatStringsSep "")
]
