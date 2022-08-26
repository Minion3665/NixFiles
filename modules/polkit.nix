{pkgs, ...}: {
  home = {
    home.packages = [
      pkgs.polkit_gnome
    ];

    wayland.windowManager.sway.config.startup = [
      {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
    ];
  };
  config = {
    security.polkit.enable = true;
    environment.systemPackages = [pkgs.polkit];
  };
}
