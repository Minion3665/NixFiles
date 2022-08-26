{pkgs, ...}: {
  home.wayland.windowManager.sway.config.startup = [
    {
      command = "\"pkill glpaper; ${pkgs.glpaper}/bin/glpaper eDP-1 ${./glpaper/shader.glsl} -F -W 1920 -H 1080\"";
      always = true;
    }
  ];
}
