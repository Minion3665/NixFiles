{ config, ... }: {
    programs.zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "crunch";
        };
        history = {
            size = 10000;
            path = "${config.xdg.dataHome}/zsh/history";
            expireDuplicatesFirst = true;
            extended = true;
        };
        initExtra = ''
            bindkey "\'\'$\{key[Up]}" up-line-or-search

            command_not_found_handler ()
            {
                local p='/nix/store/ycclzpk99snlrk8sg9n4j8pm1927gavw-command-not-found/bin/command-not-found';
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
            ZSH_HIGHLIGHT_STYLES[comment]='fg=243';
        '';
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        autocd = true;
        dotDir = ".local/share/zsh";
    };
}
