{ pkgs
, home
, username
, fzf-tab
, ...
}: {
  home = {
    programs.zsh = {
      enable = true;
      plugins = [
        {
          name = "fzf-tab";
          src = fzf-tab;
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "crunch";
      };
      history = {
        size = 10000;
        path = "${home.xdg.dataHome}/zsh/history";
        expireDuplicatesFirst = true;
        extended = true;
      };
      initExtra = ''
        unset __HM_SESS_VARS_SOURCED
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        bindkey -v
        bindkey "\'\'$\{key[Up]}" up-line-or-search

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243';
        typeset -gA ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[comment]='fg=248';


        if [[ $SHLVL != "1" ]]; then
        export RPS1=$'%{\033[38;5;248m%}(%{$fg[red]%}L$SHLVL%{\033[38;5;248m%})%{\033[39m\033[49m%} '
        fi

        function tempd {
            cd "$(mktemp -d)"
        }

            # disable sort when completing `git checkout`
            zstyle ':completion:*:git-checkout:*' sort false
            # set descriptions format to enable group support
            zstyle ':completion:*:descriptions' format '[%d]'
            # set list-colors to enable filename colorizing
            zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
            # preview directory's content with exa when completing cd
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 -l --color=always $realpath'
            # switch group using `,` and `.`
            zstyle ':fzf-tab:*' switch-group ',' '.'
            enable-fzf-tab

            alias compinit="true"

            ulimit -n 131072

            source "${./zsh/completions/bun.zsh}"
            source "${./zsh/completions/charm.zsh}"
      '';
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      autocd = true;
      dotDir = ".config/zsh";
    };

    home = {
      shellAliases = {
        ":q" = "exit";
        "q" = "exit";
      };
      packages = [ pkgs.fzf ];
    };
  };
  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".local/share/zsh" ];
}
