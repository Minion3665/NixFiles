{ config, ... }: {
  config = {
    nix.extraOptions = ''
      !include ${config.sops.secrets.access-tokens.path}
    '';

    sops.secrets.access-tokens = {
      mode = "0440";
      group = config.users.groups.keys.name;
      sopsFile = ../secrets/access-tokens;
      format = "binary";
    };
  };
}
