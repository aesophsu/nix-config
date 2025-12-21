{ mylib, ... }:
{
  imports = mylib.scanPaths ./.;  # Imports editor configurations
}
