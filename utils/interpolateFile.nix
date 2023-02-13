{ utils, pkgs }: file: pkgs.lib.pipe file [
  utils.readFile
  (text: pkgs.writeTextFile {
    name = builtins.baseNameOf file;
    inherit text;
    executable = true; # TODO: write and use utils.isExecutable
  })
]
