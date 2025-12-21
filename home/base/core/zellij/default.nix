let
  shellAliases = {
    "zj" = "zellij";  # Alias for zellij
  };
in
{
  # Enable Zellij terminal multiplexer
  programs.zellij = {
    enable = true;
  };

  # Shell aliases for Bash/Zsh and Nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
