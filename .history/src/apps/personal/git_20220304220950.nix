{ config, pkgs, nixpkgs }: {
    programs.git = {
        enable = true;

        userName = "Skyler Turner";
        userEmail = "skyler@clicksminuteper.net";

        signing = {
          key = "24D31D3B1B986F33";
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
        };
    };
}