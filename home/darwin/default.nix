{
  mylib,
  myvars,
  ...
}:
{
  # Set home directory based on user variable
  home.homeDirectory = "/Users/${myvars.username}";

  # Import necessary configurations
  imports = (mylib.scanPaths ./.) ++ [
    ../base/core
    ../base/home.nix
  ];

  # Enable management of XDG base directories on macOS
  xdg.enable = true;
}
