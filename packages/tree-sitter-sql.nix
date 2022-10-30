{
  tree-sitter,
  callPackage,
  fetchFromGitHub,
  lib
}: let
  version = "218b672499729ef71e4d66a949e4a1614488aeaa";
in callPackage "${tree-sitter}/grammar.nix" {} {
  language = "sql";
  version = builtins.substring 0 7 version;
  source = fetchFromGitHub {
    owner = "m-novikov";
    repo = "tree-sitter-sql";
    rev = version;
    hash = lib.fakeSha256;
  };
}
