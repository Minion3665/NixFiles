{ pkgs, username, ... }: {
  home.home.packages = [ pkgs.obsidian ];
  config = {
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/obsidian"
    ];
    internal.allowUnfree = [ "obsidian" ];
  };
}
