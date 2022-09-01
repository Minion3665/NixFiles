{username, ...}: {
  home.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [".local/share/direnv/allow/"];
}
