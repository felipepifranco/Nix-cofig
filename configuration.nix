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
  

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable the X11 windowing system.
  services.xserver ={
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    autoRepeatDelay = 200; # o quanto pode repetir uma tecla
    autoRepeatInterval = 35;
    xkb = { # teclado
      layout = "br";
      variant = "";
    };
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.felps = {
    isNormalUser = true;
    description = "felps";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true; # install firefox
  programs.steam.enable = true; #install steam

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    obsidian  
    discord
    # alacritty
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
