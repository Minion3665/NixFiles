{ pkgs
, lib
, ...
}: {
  config.system.activationScripts.report-changes = ''
    PATH=$PATH:${lib.makeBinPath (with pkgs; [nvd nix])}
    nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)
  '';

  home.home.packages = [ pkgs.nvd ];
}
