{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Tools related to Nix
    nix-index
    nix-tree
    nix-output-monitor
    # Miscellaneous utilities
    gnupg  # GPG encryption
  ];

  # Modern replacement for `ls`
  programs.eza = {
    enable = true;
    enableNushellIntegration = false;  # Disable Nushell integration
    git = true;
    icons = "auto";  # Automatically enable icons in the terminal
  };

  # Syntax-highlighted `cat`
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";  # Use `less` pager for output
    };
  };

  # Command-line fuzzy finder
  programs.fzf.enable = true;

  # Fast `tldr` (Rust-based)
  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = false;
        auto_update_interval_hours = 720;  # Update every 30 days
      };
    };
  };

  # Smarter `cd` command with directory ranking
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  # Shell history with SQLite (context-aware)
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
}
