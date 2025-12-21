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
  # Enable Bash and Zsh with specific environment configurations
  programs.bash = {
    enable = true;
    bashrcExtra = lib.mkAfter (envExtra + initContent);  # Append environment variables and Conda initialization
  };
  programs.zsh = {
    enable = true;
    inherit envExtra initContent;  # Use the same environment variables and Conda initialization for Zsh
  };
}
