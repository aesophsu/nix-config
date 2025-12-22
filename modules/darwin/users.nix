{
  myvars,
  pkgs,
  ...
}:

{
  # Define user and set home directory
  users.users."${myvars.username}" = {
    home = "/Users/${myvars.username}";
  };
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
}
