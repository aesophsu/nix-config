{
  config,
  lib,
  pkgs,
  myvars,
  ...
}:
{
  # Remove existing Git configuration to use the managed one
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ${config.home.homeDirectory}/.gitconfig
  '';

  # GitHub CLI tool setup
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";  # Enable GitHub CLI prompts
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
    hosts = {
      "github.com" = {
        "users" = {
          "aesophsu" = null;
        };
        "user" = "aesophsu";
      };
    };
  };

  # Git configuration with custom email for work
  programs.git = {
    enable = true;
    lfs.enable = true;

    includes = [
      {
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
    ];

    settings = {
      user.email = myvars.useremail;
      user.name = myvars.userfullname;
      init.defaultBranch = "main";
      trim.bases = "develop,master,main";  # For git-trim
      push.autoSetupRemote = true;
      pull.rebase = true;
      log.date = "iso";  # ISO date format for logs
      url = {
        "ssh://git@github.com/aesophsu" = {
          insteadOf = "https://github.com/aesophsu";
        };
      };
    };
  };

  # Git diff tool with syntax highlighting
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      diff-so-fancy = true;
      line-numbers = true;
      true-color = "always";
    };
  };

  # Git terminal UI (TUI)
  programs.lazygit.enable = true;

  # Git TUI alternative (not enabled by default)
  programs.gitui.enable = false;
}
