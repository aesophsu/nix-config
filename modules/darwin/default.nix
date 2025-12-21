{ mylib, ... }:
{
  # Import paths for modules
  imports = (mylib.scanPaths ./.) ++ [
    ../base  # Base module for shared configurations
  ];
}
