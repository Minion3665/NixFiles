{ pkgs, git-confirm, ... }: {
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

        aliases = {
            recommit = "!git commit -eF $(git rev-parse --git-dir)/COMMIT_EDITMSG";
            stash-working = ''
            !f() {
                git commit --quiet --no-verify -m \"temp for stash-working\" && \
                git stash push \"$@\" && \
                git reset --quiet --soft HEAD~1;
            }; f'';  # https://stackoverflow.com/a/60875082/12293760
        };

        extraConfig = {
            init.defaultBranch = "development";
            color.ui = "auto";
            core.autocrlf = "input";
            pull.rebase = "merges";
            credential.helper = "store";
            commit.signOff = true;
            core.splitIndex = true;
            core.untrackedCache = true;
            core.fsmonitor = true;
            hooks.confirm.match = [ "TODO" "FIXME" "HACK" "BUG" "XXX" "LAZY" ];
        };
    };

    home.file.".config/git/hooks/pre-commit".source = "${git-confirm}/hook.sh";

    home.packages = [
        pkgs.git-review
    ];
}
