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
    extraGroups = [ "networkmanager" "wheel" ];
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
  };

  # DESKTOP/WINDOW MANAGMENT
    services.xserver ={
      enable = true;
      displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;
      autoRepeatDelay = 200; # o quanto pode repetir uma tecla
      autoRepeatInterval = 35;
      xkb = { # teclado
        layout = "br";
        variant = "";
      };
    };

  programs.niri.enable = true;

  services.xserver.libinput.enable = true; #touchpad

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # AUDIO
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # PROGRAMAS E PACOTES

  programs.firefox.enable = true; # install firefox
  programs.steam.enable = true; #install steam

  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    waybar
    fuzzel # abrir o window dinamico
    swaybg
    xwayland-satellite # TODO: ver
    xdg-desktop-portal # TODO: ver
    obsidian  
    discord
    vscode-fhs
    gdb
    gcc
    tealdeer
    xclip
    bat
    # wget
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  

  hardware.bluetooth = {
   enable = true;
   powerOnBoot = true;
  }; 
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
