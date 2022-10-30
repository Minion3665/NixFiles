{pkgs, ...}: {
  config.fonts = {
    fonts = with pkgs; [
      roboto
      roboto-mono
      roboto-slab
      twitter-color-emoji
      octicons
      powerline-symbols
      monocraft
      nerdfonts-glyphs
    ];

    fontDir.enable = true;
    enableDefaultFonts = true;

    fontconfig.defaultFonts = {
      serif = ["Roboto Slab" "octicons"];
      sansSerif = ["Roboto" "octicons"];
      monospace = ["Liga Roboto Mono" "octicons"];
      emoji = ["Twitter Color Emoji" "octicons"];
    };
  };
}
