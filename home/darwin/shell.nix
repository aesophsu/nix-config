{ lib, ... }:
let
  # Additional environment variables to add to PATH
  envExtra = ''
    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
  '';
  # Conda initialization based on architecture
  initContent = ''
    arch=$(uname -m)
    if [ "aarch64" = "$arch" ] || [ "arm64" = "$arch" ]; then
      if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
      else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
      fi
    elif [[ "x86_64" = "$arch" ]]; then
      true  # Do nothing for x86_64
    fi
  '';
in
{
  # Enable Zsh with specific environment configurations
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zshrcExtra = lib.mkAfter (envExtra + initContent);  # Combine environment variables and Conda initialization
  };
}
