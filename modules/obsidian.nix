{pkgs}: {
  home.home.packages = [ pkgs.obsidian ];
  config = {
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/Obsidian"
    ];
    internal.allowUnfree = [ "obsidian" ];
  };
}
