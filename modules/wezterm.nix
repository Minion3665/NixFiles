{ pkgs, ... }: {
  home = {
    programs.wezterm = {
      enable = true;

      extraConfig = ''
        return {
          color_scheme = "OneHalfDark",
          visual_bell = {
            fade_in_duration_ms = 50,
            fade_out_duration_ms = 50,
          },
          window_padding = {
            left = '0.5cell',
            right = '0.5cell',
            top = '3px',
            bottom = '3px',
          },
          hide_tab_bar_if_only_one_tab = true,
          window_frame = {
            active_titlebar_bg = '#313640',
            inactive_titlebar_bg = '#313640',
          },
          colors = {
            tab_bar = {
              inactive_tab = {
                bg_color = '#474e5d',
                fg_color = 'white',
              },
              new_tab = {
                bg_color = '#474e5d',
                fg_color = 'white',
              },
              active_tab = {
                bg_color = '#98c379',
                fg_color = '#474e5d',
              },
            },
          },
          default_cursor_style = 'BlinkingBar',
          cursor_blink_rate = 600,
          cursor_blink_ease_in = 'Constant',
          cursor_blink_ease_out = 'Constant',
        }
      '';
    };
    home.shellAliases = {
      icat = "wezterm imgcat";
      imgcat = "wezterm imgcat";
    };
  };
}
