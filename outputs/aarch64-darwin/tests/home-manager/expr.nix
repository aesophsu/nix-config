{
  myvars,
  lib,
  outputs,
}:
let
  # =====================================================================================
  # Test scope
  # =====================================================================================

  username = myvars.username;

  hosts = [
    "fern"
    "frieren"
    "stella"
  ];

in
# =====================================================================================
# Actual home directory from evaluated darwin configurations
# =====================================================================================

lib.genAttrs hosts (
  name:
    outputs.darwinConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
)
