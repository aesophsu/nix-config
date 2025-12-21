{ config, ... }:

{
  # Disable conflicting Determinate Nix installation
  nix.enable = false;

  # Disable auto-store optimization to prevent linking errors
  nix.settings.auto-optimise-store = false;
  nix.gc.automatic = false;

  system.stateVersion = 5;

  # Include secrets access tokens for additional configuration
  nix.extraOptions = ''
    !include ${config.age.secrets.nix-access-tokens.path}
  '';
}
