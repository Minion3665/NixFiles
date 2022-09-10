{pkgs, ...}: {
  home = {
    packages = [pkgs.nvimpager];
    shellAliases = {
      less = "${pkgs.nvimpager}/bin/nvimpager";
      zless = "${pkgs.nvimpager}/bin/nvimpager";
      vimpager = "${pkgs.nvimpager}/bin/nvimpager";
    };
    sessionVariables = {
      PAGER = "${pkgs.nvimpager}/bin/nvimpager";
      MANPAGER = "${pkgs.nvimpager}/bin/nvimpager";
    };
  };
}
