{
  description = "Milan Sue's nix configuration for both NixOS & macOS";

  outputs = inputs: import ./outputs inputs;

  nixConfig = {
    extra-substituters = [
      # "https://nix-gaming.cachix.org"
      # "https://nixpkgs-wayland.cachix.org"
      # "https://install.determinate.systems"
    ];

    extra-trusted-public-keys = [
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      # "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
    ];
  };

  inputs = {

    # =====================================================================================
    # Core nixpkgs sources
    # =====================================================================================

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";          # Main package set
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";      # Stable fallback
    nixpkgs-2505.url = "github:nixos/nixpkgs/nixos-25.05";        # Older stable snapshot
    nixpkgs-mesa.url = "github:nixos/nixpkgs/2b1f0ea3ee3952e68b164efa0a1c5e394ef2e781"; # Mesa pin

    nixpkgs-master.url = "github:nixos/nixpkgs/master";           # Latest upstream (selective use)
    nixpkgs-patched.url = "github:ryan4yin/nixpkgs/nixos-unstable-patched"; # Custom patches


    # =====================================================================================
    # macOS / Darwin support
    # =====================================================================================

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";                              # macOS system management
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };


    # =====================================================================================
    # Home Manager & module system
    # =====================================================================================

    home-manager = {
      url = "github:nix-community/home-manager/master";            # User environment management
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";                  # Module auto-loading framework
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # =====================================================================================
    # System provisioning / installation / security (mainly for NixOS)
    # =====================================================================================

    disko = {
      url = "github:nix-community/disko/v1.11.0";                  # Declarative disk partitioning
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";              # Secure Boot for NixOS
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix/4835b1dc898959d8547a871ef484930675cb47f1"; # Secrets management
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";       # Persistent state management

    nixos-generators = {
      url = "github:nix-community/nixos-generators";               # ISO / VM / image generation
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # =====================================================================================
    # Developer experience & tooling
    # =====================================================================================

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";                          # Git hooks via Nix
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nuenv = {
      url = "github:DeterminateSystems/nuenv";                      # Nushell dev environments
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpak = {
      url = "github:nixpak/nixpak";                                 # Sandboxed desktop apps
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # =====================================================================================
    # Desktop / UI / applications
    # =====================================================================================

    catppuccin = {
      url = "github:catppuccin/nix";                                # Theming framework
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty/tip";                # Terminal emulator

    helix = {
      url = "github:mattwparas/helix/steel-event-system";           # Helix editor (experimental branch)
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun/v25.9.3";                     # Wayland application launcher
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender-bin = {
      url = "github:edolstra/nix-warez?dir=blender";                # Prebuilt Blender binary
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # =====================================================================================
    # Gaming
    # =====================================================================================

    nix-gaming = {
      url = "github:fufexan/nix-gaming";                            # Gaming-related packages & tweaks
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-25.11";        # Anime game launcher


    # =====================================================================================
    # Apple Silicon / Asahi Linux
    # =====================================================================================

    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon/release-2025-11-18"; # Apple Silicon NixOS support
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # =====================================================================================
    # Non-flake repositories (raw sources)
    # =====================================================================================

    nu_scripts = {
      url = "github:ryan4yin/nu_scripts";                           # Nushell utility scripts
      flake = false;
    };

    wallpapers = {
      url = "github:ryan4yin/wallpapers";                           # Wallpaper assets
      flake = false;
    };


    # =====================================================================================
    # Personal / private repositories (replace with your own)
    # =====================================================================================

    mysecrets = {
      url = "git+ssh://git@github.com/ryan4yin/nix-secrets.git?shallow=1"; # Private secrets repo
      flake = false;
    };

    my-asahi-firmware = {
      url = "git+ssh://git@github.com/ryan4yin/asahi-firmware.git?shallow=1"; # Asahi firmware blobs
      flake = false;
    };


    # =====================================================================================
    # NUR packages
    # =====================================================================================

    nur-ryan4yin = {
      url = "github:ryan4yin/nur-packages";                          # Custom NUR overlay
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

