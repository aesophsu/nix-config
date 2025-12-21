let
  shellAliases = {
    k = "kubectl";  # Alias for kubectl
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";  # Decode URL
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";  # Encode URL
  };

  localBin = "${config.home.homeDirectory}/.local/bin";
  goBin = "${config.home.homeDirectory}/go/bin";
  rustBin = "${config.home.homeDirectory}/.cargo/bin";
  npmBin = "${config.home.homeDirectory}/.npm/bin";
in
{
  # Bash setup with additional directories in PATH
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:${localBin}:${goBin}:${rustBin}:${npmBin}"
    '';
  };

  # Shell aliases available in Bash/Zsh and Nushell
  home.shellAliases = shellAliases;

  # Launch Nushell in Bash and inherit shell aliases
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    inherit shellAliases;
  };
}
