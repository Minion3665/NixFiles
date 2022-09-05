{
  pkgs,
  username,
  ...
}: {
  home.home.packages = [pkgs.steam-run];

  config = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
    hardware.steam-hardware.enable = true;

    internal.allowUnfree = ["steam" "steam-original" "steam-runtime"];
    environment.persistence."/large/persist".users.${username}.directories = [".local/share/Steam"];
  };
}
