{ lib }: rec {
  # ============================================
  # 基础网络设置 (仅作参考与 DNS 解析)
  # ============================================
  mainGateway = "10.0.0.1";
  proxyGateway = "10.0.0.2"; # 即使暂时不用，留着也不会影响系统

  nameservers = [
    "119.29.29.29" # DNSPod
    "223.5.5.5"    # AliDNS
  ];

  prefixLength = 27; 

  # ============================================
  # 主机账本：目前仅作为元数据存在
  # ============================================
  hostsAddr = {
    stella = {
      iface = "en0";
      ipv4 = "10.0.0.3";
    };
    shakky = {
      iface = "en0";
      ipv4 = "10.0.0.4"; 
    };
  };

  # ============================================
  # 硬件接口逻辑：确保移动办公不冲突
  # ============================================
  hostsInterface =
    lib.attrsets.mapAttrs (key: val: {
      interfaces."${val.iface}" = {
        useDHCP = true;      # 核心：开启 DHCP，确保在任何地方都能自动联网
        ipv4.addresses = []; # 核心：清空静态地址列表，防止写死 IP
      };
    })
    hostsAddr;

  # ============================================
  # SSH 功能区：以备注形式存在
  # ============================================
  ssh = {
    extraConfig = (
      lib.attrsets.foldlAttrs (
        acc: host: val:
          acc
          + ''
            # Host ${host}
            #   HostName ${val.ipv4}
            #   Port 22
          ''
      ) ""
      hostsAddr
    );

    knownHosts =
      lib.attrsets.mapAttrs
      (host: value: {
        # 修正：lib.optional (hostsAddr ? ${host}) ... 
        # 原代码逻辑稍显冗余，这里保证了即便未来增加主机也能正确生成
        hostNames = [host] ++ (lib.optional (hostsAddr ? "${host}") hostsAddr."${host}".ipv4);
        publicKey = value.publicKey;
      })
      {
        # GitHub 官方公钥，保留此处可确保 Git 顺畅运行
        "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
  };
}
