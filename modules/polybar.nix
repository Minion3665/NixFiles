{ lib, pkgs, ... }: {
  home = {
    services.polybar = {
      enable = true;
      settings = {
        "bar/main" = {
          "inherit" = "base";
        };
        base = {
          modules = {
            left = "xmonad";
            right = "date battery";
          };
          font = [
            "Liga Roboto Mono:style=Regular:size=10;2"
            "Twitter Color Emoji:style=Regular:antialias=false:scale=8;1"
          ];
          background = "\${colors.statusline}";
          padding = 10;
          module.margin = 5;
          margin.bottom = "\${root.padding}";
          tray.position = "right";
        };
        "module/xmonad" = {
          type = "custom/script";
          exec = "${pkgs.xmonad-log}/bin/xmonad-log";
          tail = true;
        };
        "module/date" = {
          type = "internal/date";
          date = rec {
            text = "%Y-%m-%d";
            alt = text;
          };
          time = {
            text = "%H:%M";
            alt = "%H:%M:%S";
          };
          label = "%date% %time%";
        };
        "module/battery".type = "internal/battery";
        colors = {
          black = "#282c34";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#e5c07b";
          blue = "#61afef";
          purple = "#c678dd";
          cyan = "#56b6c2";
          statusline = "#313640";
          lightgrey = "#474e5d";
          darkred = "#844C55";
          darkyellow = "#877658";
          darkgreen = "#607857";
          darkcyan = "#3F717B";
          darkblue = "#456E92";
          darkpurple = "#775289";
          white = "#dcdfe4";
        };
      };
      script = "polybar &";
    };
    systemd.user.services.polybar.Install.WantedBy = lib.mkForce [ ];
  };
}
