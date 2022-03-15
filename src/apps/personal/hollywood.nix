{ pkgs, ... }: {
    home.packages = with pkgs; [
        hollywood
        byobu
        tmux
        apg
        bash
        bmon
        ccze
        cmatrix
        htop
        mplayer
        openssh
        tree
    ];
}
