{ lib }:
{
  # =====================================================================================
  # User identity
  # =====================================================================================

  username = "sue";                         # System username
  userfullname = "Milan Sue";               # Full name (used by git, UI, etc.)
  useremail = "aesophsu@gmail.com";          # Primary email address


  # =====================================================================================
  # Networking-related variables
  # =====================================================================================

  networking = import ./networking.nix {
    inherit lib;
  };


  # =====================================================================================
  # Authentication (local account)
  # =====================================================================================

  initialHashedPassword = "";                # Optional pre-generated password hash


  # =====================================================================================
  # SSH authentication keys
  # =====================================================================================

  mainSshAuthorizedKeys = [
    # Primary SSH keys for daily access
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBmbENfEKkOW0i8nSSL6oSeIJrQMrIexaKKu1SXyMpMs sue@latepro"
  ];

  secondaryAuthorizedKeys = [
    # Backup SSH keys for recovery
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
  ];
}
