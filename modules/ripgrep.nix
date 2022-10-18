{ pkgs, ... }: {
  home.home = {
    packages = [ pkgs.ripgrep ];
    shellAliases.rg = "${pkgs.ripgrep}/bin/rg --smart-case --pretty --multiline-dotall";
  };
}
