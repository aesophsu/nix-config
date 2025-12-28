{ lib, ... }:
let
  envExtra = ''
    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
  '';
  
  initContent = ''
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    fi
  '';
in
{
  programs.bash = {
    enable = true;
    bashrcExtra = lib.mkAfter (envExtra + initContent);
  };

  programs.zsh = {
    enable = true;
    initExtra = lib.mkAfter (envExtra + initContent);
  };
  
}
