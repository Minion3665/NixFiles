{ pkgs, ... }: {
    home.packages = [
        pkgs.ripgrep
        pkgs.gnugrep
    ];

    home.shellAliases = {
        "git-todo" = "${pkgs.git}/bin/git log | ${pkgs.gnugrep}/bin/grep 'TODO\|DONE'";
        todo = "${pkgs.ripgrep}/bin/rg TODO:";
        rg = "${pkgs.ripgrep}/bin/rg -S";
    };
}
