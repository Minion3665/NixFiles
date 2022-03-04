{ config, pkgs, nixpkgs }: {
    programs.vscode.enable = true;
    .vscode.package = pkgs.vscode-fhs;

}