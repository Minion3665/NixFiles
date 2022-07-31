{ ... }: {
    home.shellAliases = builtins.listToAttrs (
        builtins.genList (value: { name = "n${toString (value - 19)}"; value = "nice -n ${toString (value - 19)}"; }) 40
    );
}
