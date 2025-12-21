let
  fontSize = 15;  # Define terminal font size
in
{
  # Set font size for various terminal programs
  programs.alacritty.settings.font.size = lib.mkForce fontSize;
  programs.ghostty.settings.font-size = lib.mkForce fontSize;
  programs.kitty.font.size = lib.mkForce fontSize;
}
