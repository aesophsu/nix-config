{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;  # Enable `vi` alias for Neovim
    vimAlias = true;  # Enable `vim` alias for Neovim
  };
}
