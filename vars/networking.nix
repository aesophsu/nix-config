{ lib }:
rec {
  # =====================================================================================
  # Network metadata (reference only)
  # Used as declarative facts for DNS / proxy / future static configs
  # =====================================================================================

  mainGateway  = "10.0.0.1";
  proxyGateway = "10.0.0.2";   # Optional proxy gateway (kept for future use)

  nameservers = [
    "119.29.29.29"             # DNSPod
    "223.5.5.5"                # AliDNS
  ];

  prefixLength = 27;


  # =====================================================================================
  # Host address ledger (metadata only)
  # No static IP is enforced at system level
  # =====================================================================================

  hostsAddr = {
    stella = {
      iface = "en0";           # Wi-Fi on macOS
      ipv4  = "10.0.0.3";
    };

    shakky = {
      iface = "en0";
      ipv4  = "10.0.0.4";
    };
  };


  # =====================================================================================
  # Interface policy abstraction
  # Ensures mobile-safe networking (DHCP-first, no hardcoded IPs)
  # =====================================================================================

  hostsInterface =
    lib.attrsets.mapAttrs (_: val: {
      interfaces."${val.iface}" = {
        useDHCP = true;        # Always prefer DHCP for portability
        ipv4.addresses = [];   # Explicitly clear static IPv4 assignments
      };
    })
    hostsAddr;


  # =====================================================================================
  # SSH-related metadata (generated hints / trust anchors)
  # =====================================================================================

  ssh = {

    # SSH config snippets (commented templates)
    extraConfig =
      lib.attrsets.foldlAttrs
        (acc: host: val:
          acc + ''
            # Host ${host}
            #   HostName ${val.ipv4}
            #   Port 22
          ''
        )
        ""
        hostsAddr;


    # Known hosts definition
    knownHosts =
      lib.attrsets.mapAttrs
        (host: value: {
          hostNames =
            [ host ]
            ++ (lib.optional (hostsAddr ? "${host}") hostsAddr."${host}".ipv4);

          publicKey = value.publicKey;
        })
        {
          "github.com".publicKey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
  };
}
