{ config, lib, ... }: 
let
  shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";  # Decode URL
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";  # Encode URL
  };

  localBin = "${config.home.homeDirectory}/.local/bin";
