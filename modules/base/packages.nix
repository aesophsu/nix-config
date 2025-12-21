{ pkgs, ... }:
{
  # =====================================================================================
  # Environment defaults
  # =====================================================================================

  environment.variables.EDITOR = "nvim --clean";


  # =====================================================================================
  # Base system packages
  # =====================================================================================

  environment.systemPackages = with pkgs; [

    # Shell & core tools
    nushell
    fastfetch
    neovim
    gnumake
    just
    git
    git-lfs

    # Monitoring
    procs
    btop

    # Archives
    zip
    xz
    zstd
    unzipNLS
    p7zip

    # Text & data processing
    gnugrep
    gawk
    gnutar
    gnused
    sad
    jq
    yq-go
    jc

    # Search & navigation
    fzf
    fd
    findutils
    (ripgrep.override { withPCRE2 = true; })

    # Disk usage
    duf
    dust
    gdu
    ncdu

    # Networking & diagnostics
    mtr
    gping
    dnsutils
    ldns
    doggo
    wget
    curl
    curlie
    httpie
    aria2
    socat
    nmap
    ipcalc
    iperf3
    hyperfine
    tcpdump

    # File transfer
    rsync
    croc

    # Security & crypto
    libargon2
    openssl

    # Misc
    file
    which
    tree
    tealdeer
  ];
}
