{
  config,
  myvars,
  ...
}:

let
  homeDir = config.users.users."${myvars.username}".home;
in
{
  # Enable GPG agent with logging configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  # Set logs for GPG agent debugging
  launchd.user.agents.gnupg-agent.serviceConfig = {
    StandardErrorPath = "${homeDir}/Library/Logs/gnupg-agent.stderr.log";
    StandardOutPath = "${homeDir}/Library/Logs/gnupg-agent.stdout.log";
  };

  # Disable password authentication for SSH
  environment.etc."ssh/sshd_config.d/200-disable-password-auth.conf".text = ''
    PasswordAuthentication no
    KbdInteractiveAuthentication no
  '';
}
