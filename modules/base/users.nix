{ myvars, ... }:
{
  # =====================================================================================
  # SSH configuration
  # =====================================================================================

  programs.ssh =
    myvars.networking.ssh;


  # =====================================================================================
  # User account
  # =====================================================================================

  users.users.${myvars.username} = {
    description = myvars.userfullname;

    openssh.authorizedKeys.keys =
      myvars.mainSshAuthorizedKeys;
  };
}
