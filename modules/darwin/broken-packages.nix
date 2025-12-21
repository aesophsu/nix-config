{ lib, ... }:

let
  # List of packages that are unsupported on macOS (Darwin)
  brokenPackages = [
    "terraform"
    "terraformer"
    "packer"
    "git-trim"
    "conda"
    "mitmproxy"
    "insomnia"
    "wireshark"
    "jsonnet"
    "zls"
    "verible"
    "gdb"
    "ncdu"
    "racket-minimal"
  ];
in
{
  # Overlay to remove broken packages from the environment
  nixpkgs.overlays = [
    (
      _: super:
      let
        removeUnwantedPackages = pname: lib.warn "the ${pname} has been removed on the darwin platform" super.emptyDirectory;
      in
      lib.genAttrs brokenPackages removeUnwantedPackages
    )
  ];
}
