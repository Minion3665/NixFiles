{ ... }: {
    home.shellAliases = builtins.listToAttrs (
        builtins.genList (value: { name = "n${value - 19}"; value = "nice -n ${value - 19}"; }) 40
    );
}
