{ pkgs, myvars, ... }:

{
  security.pam.services.sudo_local.touchIdAuth = true;

  time.timeZone = "Asia/Shanghai";

  system = {
    primaryUser = myvars.username;

    defaults = {
      dock = {
        autohide = false;
        show-recents = false;
        mru-spaces = false;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      trackpad.Clicking = true;

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 15;
        KeyRepeat = 3;
        ApplePressAndHoldEnabled = false;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = false;
    };
  };
}
