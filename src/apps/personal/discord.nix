{ pkgs, ... }: {
    home.packages = with pkgs; [
        discord
        discord-ptb
    ];
}
