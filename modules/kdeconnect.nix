{pkgs, ...}: {} # Broken by rename on latest unstable
/*{
  home.services.kdeconnect.indicator = true;
  config.programs.kdeconnect = {
    enable = true; # Can't use home-manager's version because of the firewall
    package = pkgs.plasma5Packages.kdeconnect-kde;
  };
}*/
