{ pkgs, username, ... }: {
  home.home.packages = [ pkgs.unityhub ];
  config = {
    internal.allowUnfree = [ "unityhub" ];
    environment.persistence."/large/persist".users.${username}.directories =
      [ ".config/UnityHub" ];
  };
}
