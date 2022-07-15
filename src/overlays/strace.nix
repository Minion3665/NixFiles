final: prev:  {
  strace = prev.strace.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ./strace/color.patch
    ];
  });
}
