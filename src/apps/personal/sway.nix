{ pkgs, lib, ... }: let 
  wlogoutConfig = [
    {
      label = "lock";
      action = "swaylock -c 000000 -i ${./sway/lockscreen.png}";
      text = "Lock";
      keybind = "l";
    }
    {
      label = "hibernate";
      action = "swaylock -c 000000 -i ${./sway/lockscreen.png} -f && systemctl hibernate";
      text = "Hibernate";
      keybind = "h";
    }
    {
      label = "logout";
      action = "loginctl terminate-user $USER";
      text = "Logout";
      keybind = "e";
    }
    {
      label = "shutdown";
      action = "systemctl poweroff";
      text = "Shutdown";
      keybind = "s";
    }
    {
      label = "suspend";
      action = "swaylock -c 000000 -i ${./sway/lockscreen.png} -f && systemctl suspend";
      text = "Suspend";
      keybind = "u";
    }
    {
      label = "reboot";
      action = "systemctl reboot";
      text = "Reboot";
      keybind = "r";
    }
  ];
  wlogoutJson = (builtins.toJSON wlogoutConfig);
  wlogoutConfigFile = pkgs.writeText "wlogout-layout.layout" (builtins.substring 1 ((builtins.stringLength wlogoutJson) - 2) wlogoutJson);
in {
    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;

        config = rec {
            assigns = {};
            bars = [];
            colors = {};
            defaultWorkspace = null;
            down = "j";
            floating = {};
            focus = {};
            fonts = {};
            gaps = {
                inner = 10;
                top = -10;
                outer = 0;
                smartGaps = false;
            };
            input = {
                "type:touchpad" = {
                    dwt = "enabled";
                    tap = "enabled";
                    natural_scroll = "enabled";
                    middle_emulation = "enabled";
                    events = "disabled_on_external_mouse";
                };
                "type:keyboard" = {
                    xkb_layout = "gb";
                };
                "type:tablet_tool" = {
                    map_to_output = "eDP-1";
                };
            };
            keybindings = lib.mkOptionDefault {
                "${modifier}+l" = "exec /usr/bin/env wlogout -c 5 -r 5 -p layer-shell -l ${wlogoutConfigFile}"; # "exec /usr/bin/env swaylock -c 000000";
                "XF86AudioRaiseVolume" = "exec pamixer -ui 5 && pamixer --get-volume > $WOBSOCK";
                "XF86AudioLowerVolume" = "exec pamixer -ud 5 && pamixer --get-volume > $WOBSOCK";
                "XF86AudioMute" = "exec pamixer --toggle-mute && ( pamixer --get-mute && echo 0 > $WOBSOCK ) || pamixer --get-volume > $WOBSOCK";
                "XF86AudioMicMute" = "exec pamixer --toggle-mute --default-source && ( pamixer --get-mute --default-source && echo 0 > $WOBSOCK ) || pamixer --default-source --get-volume > $WOBSOCK";
                "XF86MonBrightnessUp" = "exec light -A 5 && light -G | cut -d'.' -f1 > $WOBSOCK";
                "XF86MonBrightnessDown" = "exec light -U 5 && light -G | cut -d'.' -f1 > $WOBSOCK";
                "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | tee ~/Screenshots/\"$(date --rfc-3339=seconds)\".png | wl-copy";
                "${modifier}+g" = "sticky toggle";
                "${modifier}+minus" = "exec ${./sway/show-menu.sh}";
                "Print" = "exec grim - | tee ~/Screenshots/\"$(date --rfc-3339=seconds)\".png | wl-copy";
                "${modifier}+Print" = "exec ${./sway/toggle-backlight.sh}";
            };
            keycodebindings = {};
            left = "h";
            menu = "/usr/bin/env rofi -show combi";
            modes = {
                resize = {
                    Down = "resize grow height 10 px";
                    Escape = "mode default";
                    Left = "resize shrink width 10 px";
                    Return = "mode default";
                    Right = "resize grow width 10 px";
                    Up = "resize shrink height 10 px";
                    h = "resize shrink width 10 px";
                    j = "resize grow height 10 px";
                    k = "resize shrink height 10 px";
                    l = "resize grow width 10 px";
                };
            };
            modifier = "Mod4";
            output = {
                HDMI-A-2 = {
                    resolution = "3840x2160";
                    #position = "1920,0";
                    position = "0,0";
                };
                eDP-1 = {
                    resolution = "1920x1080";
                    #position = "0,1522";
                    position = "0,2160";
                };
                "*" = {
                    bg = "${./sway/background.png} fill";
                };
            };
            right = "l";
            seat = {
                "*" = {
                    hide_cursor = "when-typing enable";
                };
            };
            startup = [
                { command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
            ];
            terminal = "kitty";
            up = "k";
            window = {};
            workspaceAutoBackAndForth = true;
            workspaceLayout = "default";
            workspaceOutputAssign = [];
            extraConfig = ''
                set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
                exec rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob
            '';
        };

        extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
        '';

        swaynag = {
            enable = true;
            settings = {
                "<config>" = {
                    background = "#ffffff99";
                    border-bottom = "#00000000";
                    button-background = "#ffffffcc";
                    button-padding = 10;
                    button-border-size = 0;
                };

                warning = {
                    background = "#ffffff99";
                    border-bottom = "#00000000";
                    button-background = "#ffff00";
                };

                error = {
                    background = "#ffffff99";
                    border-bottom = "#00000000";
                    button-background = "#ff0000";
                };

                green = {
                    background = "#ffffff99";
                    border-bottom = "#00000000";
                    button-background = "#00b300";
                };

                blue = {
                    background = "#ffffff99";
                    border-bottom = "#00000000";
                    button-background = "#0000ff";
                };
            };
        };

        systemdIntegration = true;
    };

    home.packages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        bc
        jq
        pulseaudio
        pamixer
    ];

    programs.zsh.profileExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            exec systemd-cat -t sway sway
        fi
    '';

    systemd.user.services.avizo = {
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
            ExecReload = "kill -SIGUSR2 \$MAINPID";
            ExecStart = "${pkgs.avizo}/bin/avizo-service";
            KillMode = "mixed";
            Restart = "on-failure";
        };
        Unit = {
            After = "graphical-session.target";
            Description = "Notification daemon to show volume & brightness changes";
            Documentation = "N/A (src/apps/personal/sway.nix)";
            PartOf= "graphical-session.target";
        };
    };
}

