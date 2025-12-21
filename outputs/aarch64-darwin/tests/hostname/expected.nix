{
  lib,
  outputs,
}:
let
  # =====================================================================================
  # Hostname expectations
  # =====================================================================================

  hostsNames =
    builtins.attrNames outputs.darwinConfigurations;

in
lib.genAttrs hostsNames (name: name)
