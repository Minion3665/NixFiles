{ ... }: {
    programs.git = {
        enable = true;

        userName = "Skyler Grey";
        userEmail = "skyler3665@gmail.com";

        signing = {
            key = "D520 AC8D 7C96 9212 5B2B  BD3A 1AFD 1025 6B3C 714D";
            signByDefault = true;
            gpgPath = "gpg2";
        };

        lfs.enable = true;
        delta.enable = true;

        extraConfig = {
            init.defaultBranch = "development";
            color.ui = "auto";
            core.autocrlf = "input";
            pull.rebase = false;
            credential.helper = "store";
        };
    };
}
