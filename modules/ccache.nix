{
  username,
  config,
  ...
}: {
  config.environment.persistence."/nix/persist".users.${username}.directories = [
    {
      directory = ".cache/ccache";
      mode = "0700";
    }
  ];
}
