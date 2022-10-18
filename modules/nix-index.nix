{ pkgs
, username
, ...
}: {
  home.programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".cache/nix-index" ];
}
