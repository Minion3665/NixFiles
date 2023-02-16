{ pkgs, username, ... }: {
  home.home.packages = [ pkgs.freecad pkgs.openscad ];
  config.environment.persistence."/large/persist".users.${username}.directories = [ ".local/share/FreeCAD" ];
}
