{ mylib, ... }:
{
  imports = mylib.scanPaths ./.;  # Scans paths to include relevant configurations
}
