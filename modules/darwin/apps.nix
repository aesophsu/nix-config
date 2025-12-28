{ config, lib, pkgs, ... }:

let
  homebrew_mirror_env = {
    HOMEBREW_API_DOMAIN = "https://mirrors.bfsu.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.bfsu.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.bfsu.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.bfsu.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  homebrew_env_script = lib.attrsets.foldlAttrs (
    acc: name: value:
    acc + "\nexport ${name}=${value}"
  ) "" homebrew_mirror_env;
in
{
  environment.systemPackages = with pkgs; [ git ];

  environment.variables = {
    TERMINFO_DIRS = map (path: path + "/share/terminfo") config.environment.profiles ++ [
      "/usr/share/terminfo"
    ];
  };

  system.activationScripts.homebrew.text = lib.mkBefore ''
    echo >&2 '${homebrew_env_script}'
    ${homebrew_env_script}
  '';

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    masApps = {
      "WeChat" = 836500024;
    };

    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];

    brews = [];

    casks = [
      "google-chrome"
      "miniforge"
    ];
  };
}
