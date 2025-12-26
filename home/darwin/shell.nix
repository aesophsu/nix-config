{ lib, ... }:
let
  envExtra = ''
    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
  '';

  initContent = ''
    if [ "$(uname -m)" = "arm64" ]; then
      if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
      else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
      fi
    fi
  '';
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zshrcExtra = lib.mkAfter (envExtra + initContent);
  };
}
