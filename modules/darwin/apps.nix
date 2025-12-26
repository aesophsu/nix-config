{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Homebrew Mirror setup for manual installation (used by `brew install`)
  homebrew_mirror_env = {
    HOMEBREW_API_DOMAIN = "https://mirrors.bfsu.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.bfsu.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.bfsu.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.bfsu.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  # Proxy settings (optional, uncomment if needed)
  local_proxy_env = {
    # HTTP_PROXY = "http://127.0.0.1:7890";
    # HTTPS_PROXY = "http://127.0.0.1:7890";
  };

  # Script to export homebrew environment variables
  homebrew_env_script = lib.attrsets.foldlAttrs (
    acc: name: value:
    acc + "\nexport ${name}=${value}"
  ) "" (homebrew_mirror_env // local_proxy_env);
in
{
  # Install system-wide packages from nixpkgs
  environment.systemPackages = with pkgs; [
    git
  ];

  # Set terminfo directories to fix issues with terminfo
  environment.variables = {
    TERMINFO_DIRS = map (path: path + "/share/terminfo") config.environment.profiles ++ [
      "/usr/share/terminfo"
    ];
  };

  # Set activation script for Homebrew environment variables
  system.activationScripts.homebrew.text = lib.mkBefore ''
    echo >&2 '${homebrew_env_script}'
    ${homebrew_env_script}
  '';

  # Enable zsh and configure shells for system
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];

  # Enable homebrew installation
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    # Mac App Store apps to install
    masApps = {
      Wechat = 836500024;
    };

    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];

    brews = [
    ];

    casks = [
      "google-chrome"
      "miniforge"
    ];
  };
}
