{ ... }: {
    home.shellAliases = builtins.listToAttrs (
        builtins.genList (value: { name = "n${toString value}"; value = "nice -n ${toString value}"; }) 21
    );
}
