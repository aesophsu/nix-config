{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-output-monitor
    nix-index
    gnupg
  ];
}
