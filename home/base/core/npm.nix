{
  # Configure npm global install location
  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm
  '';
}
