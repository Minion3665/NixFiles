{ pkgs, ... }: {
  home.packages = [
    pkgs.nanorc
  ];

  home.file = {
    ".nanorc" = {
      text = "include ${pkgs.nanorc}/share/*.nanorc";
    };
  };
}
