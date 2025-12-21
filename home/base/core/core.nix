{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Tools related to Nix
    nix-output-monitor  # Monitor output of Nix builds
    hydra-check  # Check the Hydra build farm status
    nix-index  # Index Nix store paths
    nix-init  # Generate Nix derivations from URLs
    nix-melt  # TUI viewer for `flake.lock`
    nix-tree  # TUI for visualizing Nix dependencies

    # Miscellaneous utilities
    cowsay  # Fun ASCII art utility
    gnupg  # GPG encryption
    caddy  # Web server with automatic HTTPS
    ast-grep  # Code searching and linting tool
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
