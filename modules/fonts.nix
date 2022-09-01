{pkgs, ...}: {
  config.fonts = {
    fonts = with pkgs; [
      roboto
      roboto-mono
      roboto-slab
      twitter-color-emoji
      font-awesome
      material-design-icons
      powerline-symbols
    ];

    fontDir.enable = true;
    enableDefaultFonts = true;

    fontconfig.defaultFonts = {
      serif = ["Roboto Slab"];
      sansSerif = ["Roboto"];
      monospace = ["Roboto Mono"];
      emoji = ["Twitter Color Emoji"];
    };
  };
}
