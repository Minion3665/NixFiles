{ pkgs, config, fzf-tab, ... }: {
    programs.zsh = {
        enable = true;
        plugins = [ { name = "fzf-tab"; src = fzf-tab; } ];
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
        bindkey -v
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
        ZSH_HIGHLIGHT_STYLES[comment]='fg=248';


        function task_indicator {
            if [ `task +READY +OVERDUE count 2> /dev/null` -gt "0" ]  ; then
            printf "%%{\\033[38;5;248m%%}(%%{$fg[magenta]%%}$(task +READY +OVERDUE count) OVERDUE%%{\033[38;5;248m%%})%%{$fg[default]%%}"
            elif [ `task +READY +DUETODAY count 2> /dev/null` -gt "0" ]  ; then
            printf "%%{\\033[38;5;248m%%}(%%{$fg[red]%%}$(task +READY +DUETODAY count) DUE TODAY%%{\033[38;5;248m%%})%%{$fg[default]%%}"
            elif [ `task +READY +DUETomorrow count 2> /dev/null` -gt "0" ]  ; then
            printf "%%{\\033[38;5;248m%%}(%%{$fg[yellow]%%}$(task +READY +DUETomorrow count) DUE TOMORROW%%{\033[38;5;248m%%})%%{$fg[default]%%}"
            elif [ `task +READY urgency \> 10 count 2> /dev/null` -gt "0" ]  ; then
            printf "%%{\\033[38;5;248m%%}(%%{$fg[red]%%}$(task +READY urgency \\\> 10 count) URGENT%%{\033[38;5;248m%%})%%{$fg[default]%%}"
            elif [ `task +READY count 2> /dev/null` -gt "0" ]  ; then
            printf "%%{\\033[38;5;248m%%}(%%{$fg[cyan]%%}$(task +READY count) TASKS%%{\033[38;5;248m%%})%%{$fg[default]%%}"
            else
            printf "%%{\\033[38;5;248m%%}(%%{$fg[green]%%}NO TASKS%%{\033[38;5;248m%%})%%{$fg[default]%%}"
            fi
        }

        if [[ $SHLVL != "1" ]]; then
        export RPS1=$'%{\033[38;5;248m%}(%{$fg[red]%}L$SHLVL%{\033[38;5;248m%})%{\033[39m\033[49m%} '
        fi

        RPS1+='$(task_indicator)'

        function TRAPINT {
            print -n "$fg_bold[red]^C$fg_no_bold[default]"
            return $(( 128 + $1 ))
        }

        # function zle-line-init {
        #     if [[ -n $ZLE_LINE_ABORTED ]]; then
        #     MY_LINE_ABORTED="$ZLE_LINE_ABORTED"
        #     fi

        #     if [[ -n $MY_LINE_ABORTED ]]; then
        #     local savebuf="$BUFFER" savecur="$CURSOR"
        #     BUFFER="$MY_LINE_ABORTED"
        #     CURSOR="$#BUFFER"
        #     zle split-undo
        #     BUFFER="$savebuf" CURSOR="$savecur"
        #     fi
        # }
        # zle -N zle-line-init

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
            source ${./zsh/completions}/*
            '';
            enableSyntaxHighlighting = true;
            enableAutosuggestions = true;
            autocd = true;
            dotDir = ".local/share/zsh";
        };

        home.packages = [
            pkgs.fzf
        ];

        home.shellAliases = {
            ":q" = "exit";
        };
    }
