{ pkgs, ... }: {
  home.packages = [
    pkgs.polkit_gnome
  ];

  wayland.windowManager.sway.config.startup = [
    { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
  ];
}
