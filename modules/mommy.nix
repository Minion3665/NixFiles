{ pkgs, mommy, ... }:
{
  home.programs.zsh.initExtra = ''
    source ${mommy}/shell-mommy.sh
    precmd() { if (( $? != 0 )); then; mommy false; fi }
  '';
}
