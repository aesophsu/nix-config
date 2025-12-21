{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = {
      manager = {
        show_hidden = true;  # Show hidden files in file manager
        sort_dir_first = true;  # Sort directories first
      };
    };
  };
}
