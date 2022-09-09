{
  pkgs,
  config,
  username,
  lib,
  ...
}: let
  cfg = config.minion.emacs;
in {
  options.minion.emacs.enable = lib.mkEnableOption "Enable emacs";

  config = lib.mkIf cfg.enable {
    environment.persistence."/nix/persist".users.${username}.directories = [".emacs.d"];
  };

  home.programs.emacs = {
    enable = cfg.enable;
    extraPackages = epkgs: [pkgs.texlive.combined.scheme-full epkgs.citeproc
    pkgs.pdf2svg];
  };

  traces = [
    "home.programs.emacs.enable"
  ];
}
