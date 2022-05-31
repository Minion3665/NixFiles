{ pkgs, lib, ... }: let 
  scripts = import ../../utils/scriptsIn.nix lib ../../../scripts;
in {
  home.packages = map (f: pkgs.writeShellScriptBin 
    (builtins.elemAt (builtins.match "^(.*/)*(.*)\\.sh$" (toString f)) 1) 
    (builtins.readFile f)
  ) scripts;
}

