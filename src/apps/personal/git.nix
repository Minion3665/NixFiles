{ pkgs, ... }: {
    programs.git = {
        enable = true;

        userName = "Skyler Grey";
        userEmail = "skyler3665@gmail.com";

        signing = {
            key = "A773 0F0B 1D2C 7E65 DFCB  C536 8BE7 C115 369E 52A1";
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
            commit.signOff = true;
        };
    };

    home.packages = [
        pkgs.git-review
    ];
}
