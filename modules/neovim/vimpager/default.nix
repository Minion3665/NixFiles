{pkgs, ...}: {
  home = {
    packages = [pkgs.nvimpager];
    shellAliases = {
      less = "${pkgs.nvimpager}/bin/nvimpager -p";
      zless = "${pkgs.nvimpager}/bin/nvimpager -p";
      vimpager = "${pkgs.nvimpager}/bin/nvimpager";
    };
    sessionVariables = {
      /*
      PAGER = "${pkgs.nvimpager}/bin/nvimpager";
      */
      MANPAGER = "${pkgs.nvimpager}/bin/nvimpager";
    };
  };
}
