{ lib }:
rec {
  # 保持 DNS 设置，这对数据分析时下载依赖包的解析速度有帮助
  nameservers = [
    "119.29.29.29" # DNSPod
    "223.5.5.5"    # AliDNS
  ];

  # 简化 hostsAddr，仅保留当前机器 stella
  hostsAddr = {
    stella = {
      iface = "en0"; 
      ipv4  = "10.0.0.3"; # 仅作记录，实际仍走 DHCP
    };
  };

  # 保持 DHCP 策略，确保你在任何 Wi-Fi 下都能正常上网
  hostsInterface = lib.attrsets.mapAttrs (_: val: {
    interfaces."${val.iface}" = {
      useDHCP = true;
      ipv4.addresses = []; 
    };
  }) hostsAddr;

  ssh = {
    # 删除了繁琐的 extraConfig 生成逻辑
    extraConfig = "";

    # 保留 GitHub 信任，防止 Git 报错
    knownHosts = {
      "github.com" = {
        hostNames = [ "github.com" "140.82.113.3" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
    };
  };
}
