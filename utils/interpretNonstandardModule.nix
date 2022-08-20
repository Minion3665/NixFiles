# As our modules have nonstandard properties, we need to have some way of
# properly intepreting them
# This function takes a list of modules, as well as arguments to import them
# with, and returns a list of modules, each with the standard NixOS module
# properties as well as with custom properties as described in /README.md
transformArgs: modules: args: let
  resolver = module: let
    importedModule =
      if builtins.typeOf module == "path"
      then import module
      else module;
    resolvedModule =
      if builtins.typeOf importedModule == "lambda"
      then
        resolvedModule
        (transformArgs args)
      else resolvedModule;
  in {
    home = module.home or {};
    module = {
      config = module.config or {};
      imports = module.imports or {};
      options = module.options or {};
    };
  };
in (
  if modules.typeOf == "list"
  then builtins.map resolver modules
  else (resolver modules)
)
