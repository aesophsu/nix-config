{ myvars, ... }:
{
  home = {
    inherit (myvars) username;

    # Defines the Home Manager state version to ensure compatibility with the release
    stateVersion = "25.11";  # Update if needed to match current Home Manager release
  };
}
