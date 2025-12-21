{ pkgs, ... }:
{
  # Configure Squirrel Input Method with custom data
  home.file."Library/Rime" = {
    source = "${pkgs.flypy-squirrel}/share/rime-data";  # Custom Squirrel data for Flypy input method
    recursive = true;
    force = true;  # Overwrite dynamically generated data if necessary
  };
}
