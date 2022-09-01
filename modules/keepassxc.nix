{
  pkgs,
  home,
  config,
  username,
  ...
}: {
  home = {
    home.packages = [pkgs.keepassxc];
    wayland.windowManager.sway.config.startup = [
      {
        command = builtins.replaceStrings ["\n"] [" "] ''
          ${pkgs.coreutils}/bin/cat
          ${config.sops.secrets.keepassPassword.path} |
          ${pkgs.keepassxc}/bin/keepassxc --pw-stdin
          ${home.home.homeDirectory}/Sync/KeePass\ Vaults/Passwords.kdbx
        '';
      }
    ];
  };
  config = {
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/keepassxc"
    ];
    sops.secrets.keepassPassword = {
      mode = "0400";
      owner = config.users.users.${username}.name;
      group = config.users.users.nobody.group;
    };
  };
}
