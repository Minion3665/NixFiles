{ config, pkgs, nixpkgs }: {
    programs.vscode.enable = true;
    programs.vscode.package = pkgs.vscode-fhs;

}