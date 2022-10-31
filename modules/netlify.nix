{
  pkgs,
  username,
  ...
}: {
  home.home.packages = [pkgs.netlify-cli];

  config.environment.persistence."/nix/persist".users.${username}.directories = [".config/netlify"];
}
