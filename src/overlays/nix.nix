final: prev:  {
  nix = prev.nix.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ./nix/5567-make-installables-expr-context.patch
    ];
  });
}
