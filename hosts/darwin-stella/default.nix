let
  hostname = "stella";
in
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  networking.localHostName = hostname;

  system.defaults.smb.NetBIOSName = hostname;
}
