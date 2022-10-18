{ lib
, config
, ...
}:
let
  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.internal.allowUnfree;
in
{
  options.internal.allowUnfree = with lib;
    mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Unfree packages to permit installing via the AllowUnfreePredicate";
    };
  config = {
    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
    nixpkgs.config.allowUnfreePredicate = allowUnfreePredicate;
  };
}
