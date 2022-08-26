# The vim modules are sorted reverse alphabetically, so any extraConfig that is
# put in here should hopefully be the first thing to be loaded. I'm using it to
# set stuff like my mapleader
{
  programs.neovim.extraConfig = builtins.readFile ./settings.vim;
}
