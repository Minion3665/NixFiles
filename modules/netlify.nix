{
  pkgs,
  username,
  ...
}: {
  home = {
    programs.git.extraConfig.credential."https://*.netlify.app".helper = "netlify";
    home = {
      packages = [pkgs.netlify-cli];
      sessionPath = ["$HOME/.config/netlify/helper/bin"];
    };
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [".config/netlify"];
}
