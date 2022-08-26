# As our modules have nonstandard properties, we need to have some way of
# properly intepreting them
# This function takes a list of modules, as well as arguments to import them
# with, and returns a list of modules, each with the standard NixOS module
# properties as well as with custom properties as described in /README.md
lib: transformArgs: modules: args: let
  resolver = module: let
    importedModule =
      if builtins.typeOf module == "path"
      then import module
      else module;
    resolvedModule =
      if builtins.typeOf importedModule == "lambda"
      then
        importedModule
        (transformArgs args)
      else importedModule;
    moduleName =
      if builtins.typeOf module == "lambda"
      then "<AnonFunction>"
      else if builtins.typeOf module == "path"
      then builtins.toString module
      else builtins.toJSON module;
  in
    lib.warnIfNot
    ((lib.pipe resolvedModule [
        builtins.attrNames
        (lib.subtractLists ["home" "config" "imports" "options" "traces"])
      ])
      == [])
    "Module ${moduleName} had attribute names ${builtins.toJSON (builtins.attrNames resolvedModule)} but only home, config, imports and options are resolved"
    [
      {
        config = lib.recursiveUpdate (resolvedModule.config or {}) {
          home-manager.users."${args.username}".imports =
            (resolvedModule.config.home-manager.users."${args.username}".imports or [])
            ++ [resolvedModule.home or {}];
        };
        imports = resolvedModule.imports or [];
        options = resolvedModule.options or {};
      }
    ]
    ++ (builtins.map (trace: let
      splitTrace = lib.splitString "." trace;
      traceHead = builtins.head splitTrace;
      traceTail = builtins.tail splitTrace;
      resolvedTrace =
        (
          if traceHead == "home"
          then ["home-manager" "users" args.username]
          else lib.errorIfNot (traceHead == "config") []
        )
        ++ traceTail;
    in
      {config, ...}: (builtins.seq (
        lib.pipe resolvedTrace [
          (lib.foldl ({
            value,
            error,
          }: key:
            if builtins.hasAttr key value
            then {
              value = value.${key};
              inherit error;
            }
            else {
              value = {};
              error = true;
            }) {
            value = {};
            error = false;
          })
          (data: lib.warnIf data.error "trace@${moduleName}/${trace} is invalid; the key does not exist" data)
          ({
            value,
            error,
          }: {
            value = builtins.toJSON value;
            inherit error;
          })
          ({
            value,
            error,
          }: {
            value = "trace@${moduleName}/${trace}: ${value}";
            inherit error;
          })
          ({
            value,
            error,
          }:
            lib.traceIf (!error) value null)
        ]
      ) {})) (resolvedModule.traces or []));
in {
  imports = (
    if builtins.typeOf modules == "list"
    then builtins.concatLists (builtins.map resolver modules)
    else resolver modules
  );
}
