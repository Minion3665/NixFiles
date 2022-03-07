{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [
            {
                modules-left = ["sway/mode" "sway/workspaces"];

                modules-center = ["sway/window"];

                modules-right = ["battery" "clock"];

                modules = {
                    battery.bat = "BAT0";
                    "sway/window" = {
                        max-length = 50;
                    };
                };
            }
        ];
        style = ''
            window#waybar {
                background: rgba(0, 0, 0, 0);
            }

            window#waybar * * * * {
                background: alpha(@theme_base_color, 0.6);
                color: @theme_text_color;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 5px;
                margin: 10px 5px;
            }

            window#waybar * * *:first-child * {
                margin-left: 10px;
            }

            window#waybar * * *:last-child * {
                margin-right: 10px;
            }

            window#waybar * * * * * {
                margin: 0;
                background: rgba(0, 0, 0, 0);
            }

            #-window {
                width: 50em;
            }
        '';

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.sway.Unit.Wants = [ "waybar.service" ];
}
