{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
 
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "felps"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.resolved.enable = true; 

  nix.settings.experimental-features = ["nix-command" "flakes"];

  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.felps = {
    isNormalUser = true;
    description = "felps";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # GRAFICOS
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver     # VA-API (iHD) userspace
      vpl-gpu-rt             # oneVPL (QSV) runtime
      intel-compute-runtime  # OpenCL
    ];
  };
  
  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [ "i915.enable_guc=3" ];

  # DESKTOP/WINDOW MANAGMENT
  services.displayManager.ly.enable = true;
  

  services.xserver ={
    enable = true;
    videoDrivers = [ "modesetting" ];
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    autoRepeatDelay = 200; # o quanto pode repetir uma tecla
    autoRepeatInterval = 35;
    xkb = { # teclado
      layout = "br";
      variant = "";
    };
  };

  # modos de gasto de bateria
  services.power-profiles-daemon.enable = true;
  services.tlp.enable = false;

  programs.niri.enable = true;

  services.xserver.libinput.enable = true; #touchpad

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # AUDIO
# Desativa o servidor PulseAudio antigo para evitar conflitos
  services.pulseaudio.enable = false;

  # Dá prioridade máxima (Real-Time) para o áudio no processador
  security.rtkit.enable = true;

  # Configura o PipeWire moderno como o verdadeiro mestre do áudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; 
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.wireplumber.extraConfig = {
  "10-buffer-settings" = {
    "monitor.properties" = {
      # Alumenta o tamanho mínimo do buffer para evitar que caia demais em jogos
      "default.clock.min-quantum" = 1024;
      "default.clock.max-quantum" = 2048;
      # Trava a taxa de amostragem padrão (evita re-amostragem dinâmica problemática)
      "default.clock.rate" = 48000;
    };
  };
};

  # PROGRAMAS E PACOTES

  programs.firefox.enable = true; # install firefox
  programs.steam = {
    enable = true; #install steam
    protontricks.enable = true;
    remotePlay.openFirewall = true; # Necessário para o Steam Remote Play
    dedicatedServer.openFirewall = true; # Necessário para rodar servidores locais
  };

  # permite rodar binários de outros linux
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    glibc
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.shellAliases = {
    gdb = "/etc/profiles/per-user/felps/bin/pwndbg";
  };

  environment.systemPackages = with pkgs; [
    yazi
    kdePackages.dolphin
    ripdrag
    waybar
    fuzzel # abrir o window dinamico
    swaybg
    xdg-desktop-portal # TODO: ver
    xwayland-satellite # TODO: ver
    obsidian  
    discord
    vesktop
    vscode-fhs
    gdb
    gcc
    valgrind
    tealdeer
    xclip
    bat
    fastfetch
    pavucontrol
    wlogout
    obs-studio
    super-productivity
    # TP PDS2
    gnumake
    cmake
    doxygen
    gcovr
    # configurar botoes
    brightnessctl
    playerctl
    # wget
    unzip
    # IJUNIOR
    nodejs
    typescript
    btop
    thunar
  ];
  # ghidra
  programs.ghidra.enable = true;
  virtualisation.docker.enable = true;

  # whireshark
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark; # Instala a interface gráfica (Qt)

  # sql
  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  # Adicione seu usuário ao grupo do Wireshark
# Add your user to the docker group

  
  # nodejs/react solve
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
  

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
    # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
  };
  
  fonts.packages = with pkgs; [
    nerd-fonts.hurmit
  ];
  

  hardware.bluetooth = {
   enable = true;
   powerOnBoot = true;
   settings.General = {
    # Evita quedas de conexão por timeout
    DiscoverableTimeout = 0;
    PairableTimeout = 0;
  };
  }; 
  services.blueman.enable = true; # interface gráfica de bluetooth

  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #  enable = true;
  # enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  
  system.stateVersion = "25.11"; # NÃO MUDAR!!!!!!!!!

}
