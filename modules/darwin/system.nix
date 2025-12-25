{
  pkgs,
  myvars,
  ...
}:

{
  # Enable TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
  programs.rosetta.enable = true; 

  # Set system time zone
  time.timeZone = "Asia/Shanghai";

  system = {
    primaryUser = myvars.username;

    defaults = {
      # Dock settings
      dock = {
        autohide = false;
        show-recents = false;
        mru-spaces = false;
        expose-group-apps = true;
      };

      # Finder settings
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = false;
        FXEnableExtensionChangeWarning = false;
        FXDefaultSearchScope = "SCcf";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      # Trackpad settings
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };

      # Global macOS settings
      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true;
        "com.apple.sound.beep.feedback" = 0;
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 15;
        KeyRepeat = 3;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
      };

      # Custom user preferences
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          AppleSpacesSwitchOnActivate = true;
        };
        "com.apple.finder" = {
          AppleShowAllFiles = false;
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = false;
        };
        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
      };

      # Login window settings
      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = true;
      };
    };

    # Keyboard settings for remapping keys
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = false;
    };
  };
}
