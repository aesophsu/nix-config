#############################################################
#
#  Stella - MacBook Air M4 (16G)
#  The Core of Punk Records.
#
#############################################################
let
  hostname = "stella";
in
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;
}
