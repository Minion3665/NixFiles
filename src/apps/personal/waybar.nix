{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [];  # TODO: Make settings
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
                margin: 10px 0;
                transition: all 0.5s;
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
        '';

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.sway.Unit.Wants = [ "waybar.service" ];
}
