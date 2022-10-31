{pkgs, ...}: {
  home = {
    programs.waybar = {
      enable = true;
      settings = [
        {
          modules-left = ["sway/workspaces"];

          modules-center = ["sway/window"];

          modules-right = [
            "backlight"
            "pulseaudio"
            "network"
            "battery"
            "clock"
            "custom/coffee"
            "custom/notification"
            "tray"
          ];

          pulseaudio = {
            format = "{icon} {volume}%";
            format-tooltip = "{desc}";
            format-muted = "🔇 Muted";
            format-icons = [
              "🔈"
              "🔉"
              "🔊"
            ];
            states.muted = 0;
          };
          backlight = {
            format = "{icon} {percent}%";
            on-scroll-up = "${pkgs.light}/bin/light -A 3";
            on-scroll-down = "${pkgs.light}/bin/light -N 1 && ${pkgs.light}/bin/light -U 3";
            format-icons = [
              "🔅"
              "🔆"
              "☀️"
              "✨"
            ];
          };
          network = {
            format = "🔗 {ifname}";
            format-wifi = "📡 {essid} ({ifname})";
            format-disabled = "";
            format-disconnected = "🌐 No network";
            tooltip-format = "{ipaddr}/{cidr}";
            tooltip-format-wifi = "{ipaddr}/{cidr} ({signalStrength}%)";
            tooltip-format-disconnected = "Disconnected";
          };
          battery = {
            states = {
              full = 100;
              warning = 30;
              critical = 10;
            };
            format = "{icon} {capacity}%";
            format-charging = "🔌 {capacity}%";
            format-plugged = "🔌 {capacity}%";
            format-full-full = "🔌 Full";
            format-icons = {
              full = "🔋";
              warning = "🪫";
              critical = "🪫";
            };
          };
          "sway/window" = {
            max-length = 50;
          };
          clock = {
            format = "⏰ {:%T}";
            interval = 1;
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "🔔<sup><span color='#dd2e41'>●</span></sup>";
              none = "🔔";
              dnd-notification = "🔕<sup><span color='#dd2e41'>●</span></sup>";
              dnd-none = "🔕";
            };
            "return-type" = "json";
            "exec-if" = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
            "exec" = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
            on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
            on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
            escape = true;
          };
          "custom/coffee" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              none = "😴";
              inhibiting = "☕";
            };
            "return-type" = "json";
            "exec" = "while sleep 0.1; do ${pkgs.systemd}/bin/systemd-inhibit --list | grep idle | wc -l | jq '{alt: (if . == 0 then \"none\" else \"inhibiting\" end)} | tostring' -r; done";
            on-click = ./systemd-inhibit/stop-inhibiting-idle.sh;
            on-click-right = ./systemd-inhibit/inhibit-idle.sh;
            escape = true;
          };
        }
      ];
      style = builtins.readFile ./waybar/main.css;
    };

    wayland.windowManager.sway.config.startup = [
      {
        command = "\"pkill swaync; pkill waybar; ${pkgs.swaynotificationcenter}/bin/swaync & waybar\"";
        always = true;
      }
    ];
    home.packages = with pkgs; [libappindicator swaynotificationcenter];
  };
}
