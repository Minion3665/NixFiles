{
  pkgs,
  home,
  username,
  ...
}: {
  home = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "crunch";
      };
      history = {
        size = 10000;
        path = "${home.xdg.dataHome}/zsh/history";
        expireDuplicatesFirst = true;
        extended = true;
      };
      initExtra = ''
        bindkey -v
        bindkey "\'\'$\{key[Up]}" up-line-or-search

        command_not_found_handler ()
        {
            local p='command-not-found';
            if [ -x "$p" ] && [ -f '/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite' ]; then
            "$p" "$@" 2>&1 | sed -r 's/nix-shell -p (\S+)/nix shell nixpkgs#\1/g' 1>&2;
            if [ $? = 126 ]; then
            "$@";
            else
            return 127;
            fi;
            else
            echo "$1: command not found" 1>&2;
            return 127;
            fi
        }

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243';
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
            # enable-fzf-tab

            alias compinit="true"
      '';
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      autocd = true;
      dotDir = ".config/zsh";
    };

    home.shellAliases = {
      ":q" = "exit";
    };
  };
  config.environment.persistence."/nix/persist".users.${username}.directories = [".local/share/zsh"];
}