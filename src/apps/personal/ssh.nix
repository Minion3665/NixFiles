{ ... }: {
    programs.ssh = {
        enable = true;
        matchBlocks = {
            logerrit = {
                hostname = "gerrit.libreoffice.org";
                identityFile = "~/.ssh/id_rsa";
                port = 29418;
                user = "Minion3665";
            };
        };
    };

    home.shellAliases = {
        ssh = "kitty +kitten ssh";
        s = "kitty +kitten ssh";
    };
}
