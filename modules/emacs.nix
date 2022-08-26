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

  config = {
    environment.persistence."/nix/persist".users.${username}.directories = [".emacs.d"];
  };

  home.programs.emacs.enable = true;

  traces = [
    "home.programs.emacs.enable"
  ];
}
