{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktop;
in
{
  # =====================================================================================
  # Options
  # =====================================================================================

  options.modules.desktop = {
    fonts.enable =
      lib.mkEnableOption "Enable rich desktop fonts";
  };


  # =====================================================================================
  # Font packages
  # =====================================================================================

  config.fonts.packages =
    lib.mkIf cfg.fonts.enable (with pkgs; [

      # Icon fonts
      material-design-icons
      font-awesome

      # Nerd Fonts
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka

      # Noto family
      noto-fonts
      noto-fonts-color-emoji
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif

      # Adobe Source family
      source-sans
      source-serif
      source-han-sans
      source-han-serif
      source-han-mono

      # CJK & misc
      lxgw-wenkai-screen
      maple-mono.NF-CN-unhinted
    ]);
}
