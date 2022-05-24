{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [
            {
                modules-left = ["sway/workspaces"];

                modules-center = ["sway/window"];

                modules-right = ["backlight" "pulseaudio" "network" "battery" "clock" "custom/notification" "tray"];

                modules = {
                    battery.bat = "BAT0";
                    "sway/window" = {
                        max-length = 50;
                    };
                    clock = {
                        format = "{:%T}";
                        interval = 1;
                    };
                    "custom/notification" = {
                        tooltip = false;
                        format = "{icon}";
                        format-icons = {
                            notification = "<span foreground='red'><sup></sup></span>";
                            none = "";
                            dnd-notification = "<span foreground='red'><sup></sup></span>";
                            dnd-none = "";
                        };
                        "return-type" = "json";
                        "exec-if" = "which swaync-client";
                        "exec" = "swaync-client -swb";
                        on-click = "swaync-client -t -sw";
                        on-click-right = "swaync-client -d -sw";
                        escape = true;
                    };
                };
            }
        ];
        style = ''
            window#waybar {
                background: rgba(0, 0, 0, 0);
            }

            #custom-notification {
                font-family: "NotoSansMono Nerd Font";
            }

            window#waybar * * * * {
                background: alpha(@theme_base_color, 0.6);
                color: @theme_text_color;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 5px;
                margin: 10px 5px;
                transition: all 0.2s ease-in-out;
                transition: background 0s;
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

            /*window#waybar.solo,window#waybar.empty {
                background: alpha(@theme_base_color, 0.6);
            }

            window#waybar.solo *,window#waybar.empty * {
                background: rgba(0, 0, 0, 0); 
            }*/

            #window {
                min-width: 50em;
            }

            window#waybar * * * #tray * {
                padding: 0;
            }

            window#waybar * * * #tray menu *:first-child {
                margin-top: 5px;
            }            

            window#waybar * * * #tray menu *:last-child {
                margin-bottom: 5px;
            }

            window#waybar * * * #tray menu * {
                margin-left: 5px;
                margin-right: 5px;
            }

            window#waybar * * * #tray menu * * {
                margin: 5px;
            }

            window#waybar * * * #tray {
                padding: 5px;
            }

            window#waybar * * * #tray menu {
                background: alpha(@theme_base_color, 0.8);
                color: @theme_text_color;
                border: 0;
            }

            #tray menu *:hover {
                background: alpha(@theme_base_color, 1);
            }

            window#waybar #workspaces {
                padding: 0;
            }

            window#waybar #workspaces button {
                border: 0;
                margin: 0;
                padding: 5px;
            }

            window#waybar #workspaces button.focused {
                background: alpha(@theme_base_color, 0.8);
            }

            window#waybar #workspaces button.focused:hover {
                background: alpha(@theme_base_color, 0.9);
            }

            window#waybar #workspaces button:hover {
                background: alpha(@theme_base_color, 0.7);
            }

            window#waybar #workspaces button.persistent {
                background: alpha(#ffdf00, 0.5);
            }

            window#waybar #workspaces button.urgent {
                background: alpha(red, 0.5);
            }

            window#waybar #workspaces button:active {
                background: alpha(@theme_base_color, 1);
            }

            #backlight, #pulseaudio, #network, #battery {
                min-width: 3em;
            }

            window#waybar * .modules-right #custom-notification {
                margin-right: 10px;
            }

            window#waybar * .modules-right #tray {
                margin-left: 0px;
            }
        '';

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.sway.Unit.Wants = [ "waybar.service" ];
}
