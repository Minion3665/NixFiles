{ pkgs, lib, ... }: {
    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;

        config = {
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
                smartGaps = true;
            };
            input = {
                "type:touchpad" = {
                    dwt = "enabled";
                    tap = "enabled";
                    natural_scroll = "enabled";
                    middle_emulation = "enabledD";
                    events = "disabled_on_external_mouse";
                };
                "type:keyboard" = {
                    xkb_layout = "gb";
                };
            };
            keybindings = lib.mkOptionDefault {};
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
                    position = "1920,0";
                };
                eDP-1 = {
                    resolution = "1920x1080";
                    position = "0,1522";
                };
            };
            right = "l";
            seat = {
                "*" = {
                    hide_cursor = "when-typing enable";
                };
            };
            startup = [];
            terminal = "alacritty";
            up = "k";
            window = {};
            workspaceAutoBackAndForth = true;
            workspaceLayout = "default";
            workspaceOutputAssign = [];
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
                    button-border-size = 0;
                };
            };
        };

        systemdIntegration = true;
    };

    home.packages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
    ];

    programs.zsh.profileExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            exec systemd-cat -t sway sway
        fi
    '';
}