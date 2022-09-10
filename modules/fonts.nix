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
      nerdfonts-glyphs
    ];

    fontDir.enable = true;
    enableDefaultFonts = true;

    fontconfig.defaultFonts = {
      serif = ["Roboto Slab"];
      sansSerif = ["Roboto" "Symbols Nerd Font"];
      monospace = ["Roboto Mono" "Symbols Nerd Font"];
      emoji = ["Twitter Color Emoji"];
    };
  };
}
