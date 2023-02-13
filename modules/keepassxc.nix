{ pkgs
, home
, config
, username
, ...
}: {
  home = {
    home.packages = [ pkgs.keepassxc ];
  };
  config = {
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/keepassxc"
    ];
    sops.secrets.keepassPassword = {
      mode = "0000";
      owner = config.users.users.nobody.name;
      group = config.users.users.nobody.group;
    };
    security.wrappers."run_keepass" = {
      source = "${pkgs.run-keepass}/bin/run_keepass";
      setuid = true;
      owner = config.users.users.root.name;
      group = config.users.users.nobody.group;
    };
  };
}
