{ config, lib, ... }: 
let
  # Shell aliases for URL encoding and decoding
  shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";  # Decode URL
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";  # Encode URL
  };

  localBin = "${config.home.homeDirectory}/.local/bin";  # Local bin path (optional if no other bins are required)
in
{
  # Zsh setup with additional shell aliases
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zshrcExtra = ''
      export PATH="$PATH:${localBin}"
    '';
  };

  # Shell aliases available in Zsh
  home.shellAliases = shellAliases;
}
