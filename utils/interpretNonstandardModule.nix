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
  in
    lib.warnIfNot ((lib.pipe resolvedModule [
        builtins.attrNames
        (lib.subtractLists ["home" "config" "imports" "options"])
      ])
      == [])
    "Module ${
      if builtins.typeOf module == "lambda"
      then "<AnonFunction>"
      else builtins.toString module
    } had attribute names ${builtins.toJSON (builtins.attrNames resolvedModule)} but only home, config, imports and options are resolved" {
      config = lib.recursiveUpdate (resolvedModule.config or {}) {
        home-manager.users."${args.username}".imports =
          (resolvedModule.config.home-manager.users."${args.username}".imports or [])
          ++ [resolvedModule.home or {}];
      };
      imports = resolvedModule.imports or [];
      options = resolvedModule.options or {};
    };
in {
  imports = (
    if builtins.typeOf modules == "list"
    then builtins.map resolver modules
    else [(resolver modules)]
  );
}
