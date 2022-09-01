{username, ...}: {
  home.programs.zoxide = {
    enable = true;
    options = ["--cmd=cd"];
  };
  config.environment.persistence."/nix/persist".users.${username}.directories = [".local/share/zoxide"];
  # Zoxide overwrites its db file, so we can't just use .files here
}
