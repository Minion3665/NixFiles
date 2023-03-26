{ pkgs, ... }: {
  home = {
    home.sessionVariables.CARGO_NET_GIT_FETCH_WITH_CLI = "true";
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
        recommit = "!git commit --verbose -eF $(git rev-parse --git-dir)/COMMIT_EDITMSG";
        # Yes, this does need to start with an !. Removing it will make the
        # expansion in the middle not work
        stash-working = ''
          !f() {
              git commit --quiet --no-verify -m \"temp for stash-working\" && \
              git stash push \"$@\" && \
              git reset --quiet --soft HEAD~1;
          }; f''; # https://stackoverflow.com/a/60875082/12293760
        gui = ''
          !f() {
              export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
              lazygit "$@"
              if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
                  cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
                  rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
              fi
          }; f'';
        graph = ''log --graph --oneline --decorate'';
      };

      extraConfig = {
        init.defaultBranch = "development";
        color.ui = "auto";
        core.autocrlf = "input";
        pull.rebase = "merges";
        push.autoSetupRemote = true;
        credential.helper = "store";
        commit.signOff = true;
        core.splitIndex = true;
        core.untrackedCache = true;
        core.fsmonitor = true;
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
      };
    };
    home = {
      shellAliases.gg = "${pkgs.git}/bin/git gui";
      shellAliases.gs = "${pkgs.git}/bin/git status";
      shellAliases.grc = "${pkgs.git}/bin/git recommit";
      shellAliases.grca = "${pkgs.git}/bin/git recommit --amend";
      packages = with pkgs; [
        git-review
        lazygit
        git-crypt
      ];
    };
  };
}
