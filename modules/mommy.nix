{ pkgs, mommy, ... }:
let
  mommy-script = pkgs.writeScript "mommy" (builtins.readFile "${mommy}/shell-mommy.sh");
in
{
  home.programs.zsh.initExtra = ''
    source ${mommy-script}
    precmd() { if (( $? != 0 )); then; mommy false; fi }
  '';
}
