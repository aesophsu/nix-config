{
  myvars,
  ...
}:

{
  # Define user and set home directory
  users.users."${myvars.username}" = {
    home = "/Users/${myvars.username}";
    programs.zsh.enable = true;  # Set default shell to zsh
  };
}
