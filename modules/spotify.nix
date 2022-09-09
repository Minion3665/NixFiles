{
  pkgs,
  config,
  home,
  username,
  ...
}: {
  home = {
    services.spotifyd = {
      enable = true;
      settings = {
        global = {
          username_cmd = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.spotifyUsername.path}";
          password_cmd = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.spotifyPassword.path}";
          use_mpris = true;
          device_name = "background@${config.networking.hostName}";
          cache_path = "${home.home.homeDirectory}/.cache/spotifyd";
          max_cache_size = 1000000000;
          volume_normalisation = true;
          normalisation_pregain = -10;
          autoplay = true;
          zeroconf_port = 1234;
          device_type = "computer";
        };
      };
    };
    home.packages = [pkgs.spotify-tui];
  };
  config = {
    sops.secrets.spotifyUsername = {
      mode = "0400";
      owner = config.users.users.${username}.name;
      group = config.users.users.nobody.group;
    };
    sops.secrets.spotifyPassword = {
      mode = "0400";
      owner = config.users.users.${username}.name;
      group = config.users.users.nobody.group;
    };
    environment.persistence."/nix/persist".users.${username}.directories = [".cache/spotifyd"];
  };
}
