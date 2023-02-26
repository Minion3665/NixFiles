final: prev: let
  programs = [
    /* "steam" */
    /* "prismlauncher" */
  ];
in prev.lib.pipe programs [
  (map (name: {
    inherit name;
    value = prev.${name}.overrideAttrs (prevAttrs: {
      postInstall = (prevAttrs.postInstall or "") + ''
        sed -i 's/^Exec=/&prime-run /g' $out/share/applications/*.desktop
      '';
    });
  }))
  builtins.listToAttrs
]
