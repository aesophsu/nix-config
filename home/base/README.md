# Home Manager's Base Submodules

This directory contains cross-platform base configurations that are shared between Linux and Darwin
systems.

## Configuration Structure

### Core System

- **core/**: Essential cross-platform configurations
  - **core.nix**: Minimal home-manager configuration
  - **shells/**: Shell configurations (bash, zsh, fish, nu)
  - **git.nix**: Git configuration and aliases
  - **pip.nix**: Python package management
  - **starship.nix**: Cross-shell prompt configuration
  - **theme.nix**: Color schemes and theming

### Desktop Environment

- **gui/**: Cross-platform GUI applications and configurations
  - **dev-tools.nix**: Development tools and IDEs
  - **media.nix**: Media players and utilities
  - **terminal/**: Terminal emulator configurations
    - **alacritty/**: Alacritty terminal
    - **kitty/**: Kitty terminal
    - **foot/**: Foot terminal (Linux)
    - **ghostty/**: Ghostty terminal


### System Management

- **home.nix**: Main home manager configuration file

## Platform Compatibility

All configurations in this directory are designed to work across:

- **Linux**: All distributions with Nix and Home Manager
- **macOS**: Darwin systems with Home Manager
- **WSL**: Windows Subsystem for Linux

## Usage

These base configurations provide the foundation for both Linux and Darwin systems, ensuring
consistent environments across different platforms while allowing for platform-specific
customizations.
