{ lib, pkgs, ... }: {
  home = {
    services.picom = {
      enable = true;
      package = pkgs.picom-next;
      experimentalBackends = true;
      backend = "glx";
      fade = true;
      inactiveOpacity = 0.9;
      vSync = true;
      settings = {
        blur.method = "dual_kawase";
        corner-radius = 10;
        glx-no-stencil = true;
        unredir-if-possible = true;
        use-damage = true;
        no-fading-openclose = true;
        fade-in-step = 0.005;
        fade-out-step = 0.005;
        no-fading-larger-than = 0.1;
        blur-background-exclude = [
          "class_g = 'slop'"
        ];
        rounded-corners-exclude = [
          "class_g = 'Polybar'"
          "class_g = 'slop'"
        ];
      };
    };
    systemd.user.services.picom.Install.WantedBy = lib.mkForce [ ];
  };
}
