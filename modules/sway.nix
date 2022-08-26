{
  pkgs,
  lib,
  ...
}: {
  home = {
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
          "${modifier}+g" = "sticky toggle";
          "${modifier}+k" = "exec wl-copy -c";
          "${modifier}+f" = "maximize toggle";
        };
        keycodebindings = {};
        left = "h";
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
            bg = "#FFD0F9 solid_color";
            position = "0,0";
          };
          eDP-1 = {
            resolution = "1920x1080";
            position = "0,2160";
          };
          "*" = {
          };
        };
        right = "l";
        seat = {
          "*" = {
            hide_cursor = "when-typing enable";
          };
        };
        startup = [
          {command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK";}
        ];
        terminal = "${pkgs.kitty}/bin/kitty";
        up = "k";
        window = {};
        workspaceAutoBackAndForth = true;
        workspaceLayout = "default";
        workspaceOutputAssign = [];
      };

      extraSessionCommands = ''
        export WLR_NO_HARDWARE_CURSORS=1
        # TODO: Check if above is still needed w/ nvidia card enabled
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';

      swaynag = {
        enable = false;
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
      wl-clipboard
    ];

    programs.zsh.profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec systemd-cat -t sway sway --unsupported-gpu
      fi
    '';
  };
}
