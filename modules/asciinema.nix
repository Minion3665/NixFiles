{ pkgs, username, ... }: {
  home.home.packages = [ pkgs.asciinema ];
  config.environment.persistence."/nix/persist".users.${username}.directories = [
    ".config/asciinema"
  ];
}
