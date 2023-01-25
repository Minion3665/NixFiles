{ pkgs
, username
, nix-index-database
, ...
}: {
  home.imports = [ nix-index-database.hmModules.nix-index ];

  home.programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    command-not-found.enable = false;
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".cache/nix-index" ];
}
