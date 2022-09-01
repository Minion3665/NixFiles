{
  pkgs,
  username,
  ...
}: {
  home.home.packages = [pkgs.nix-index];

  config.environment.persistence."/nix/persist".users.${username}.directories = [".cache/nix-index"];
}
