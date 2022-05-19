{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    rnix-lsp
  ];
}