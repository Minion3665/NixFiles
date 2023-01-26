{ lib
, config
, ...
}: {
  options.internal.traces = with lib;
    mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Options to trace (for debugging)";
    };
}
