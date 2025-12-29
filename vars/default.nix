{ lib }:
{
  username = "sue"; 
  userfullname = "Milan Sue";
  useremail = "aesophsu@gmail.com";

  networking = import ./networking.nix { inherit lib; };

  # 对于只在本地工作的用户，这些可以保持默认或留空
  initialHashedPassword = ""; 
  mainSshAuthorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBmbENfEKkOW0i8nSSL6oSeIJrQMrIexaKKu1SXyMpMs sue@latepro"
  ];
  secondaryAuthorizedKeys = [];
}
