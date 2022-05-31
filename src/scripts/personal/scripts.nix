{ pkgs, lib, ... }: let 
  scripts = import ../../utils/scriptsIn.nix lib ../../../scripts;
in {
  home.packages = map (f: pkgs.writeShellScriptBin 
    (builtins.elemAt (builtins.match "^(.*/)*(.*)\\.sh$" (toString f)) 1) 
    (builtins.replaceStrings ["BASH_SOURCE[0]"] ["echo ${f}"] (builtins.readFile f))
  ) scripts;
}

