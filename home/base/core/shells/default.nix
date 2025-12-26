{ config, ... }: 
let
  localBin = "${config.home.homeDirectory}/.local/bin";
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:${localBin}"
    '';
  };

  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
  };
}
