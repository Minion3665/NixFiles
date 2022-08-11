{ pkgs, ... }: {
    home.packages = [
        pkgs.taskwarrior
        pkgs.taskwarrior-tui
        pkgs.ptask
    ];
}
