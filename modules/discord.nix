{ pkgs, ... }: {
  home.home = {
    packages = with pkgs; [
      discord
    ];

    file.".config/discord/settings.json".text = builtins.toJSON {
      IS_MAXIMIZED = true;
      IS_MINIMIZED = false;
      BACKGROUND_COLOR = "#202225";
      WINDOW_BOUNDS = {
        x = 485;
        y = 2341;
        width = 950;
        height = 762;
      };
      DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
      SKIP_HOST_UPDATE = true;
    };
  };

  config.internal.allowUnfree = [ "discord" ];
}
