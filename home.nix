{ config, pkgs, ...}:

let 
  dir = ./programs;
in
{
  imports = [
    (dir + "/fish.nix")
    (dir + "/alacritty.nix")
    (dir + "/git.nix")
    (dir + "/niri.nix")
    (dir + "/cibersec_tools.nix")
    (dir + "/fuzzel.nix")
  ];

  home.sessionVariables = {
    TERMINAL = "alacritty";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NH_FLAKE="/etc/nixos";

    # Força o Java a usar a renderização em tela correta via XWayland, evitando falhas de GPU
    _JAVA_OPTIONS = "-Dsun.java2d.xrender=true";
  };

  xdg.desktopEntries.steam = {
    name = "Steam";
    genericName = "Gestor de Jogos";
    exec = "steam -cef-disable-gpu-compositing %U"; # resolver bug de tela preta
    icon = "steam";
    terminal = false;
    categories = [ "Network" "FileTransfer" "Game" ];
    type = "Application";
  };

  home.username = "felps";
  home.homeDirectory = "/home/felps";
  home.stateVersion = "25.11";

  # thunar
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.theme = config.gtk.theme;
    gtk4.extraCss = config.gtk.gtk3.extraCss;
    gtk3.extraCss = ''
      @define-color bg_color #011319;
      @define-color fg_color #b1bac4;
      @define-color selected_bg_color #33d6a1;
      @define-color selected_fg_color #011319;
      @define-color accent_color #39c5cf;
      @define-color theme_bg_color #011319;
      @define-color theme_fg_color #b1bac4;
      @define-color theme_selected_bg_color #33d6a1;
      @define-color theme_selected_fg_color #011319;
      @define-color sidebar_bg #011a22;
      @define-color button_bg #022530;
      @define-color button_hover #033645;

      window.background { background-color: @bg_color; color: @fg_color; }
      .view { background-color: @bg_color; color: @fg_color; }
      
      /* Sidebar fixes for Thunar and File Choosers */
      placessidebar,
      placessidebar viewport,
      placessidebar row,
      .sidebar,
      .sidebar viewport,
      sidebar row,
      stacksidebar row { 
        background-color: @sidebar_bg !important; 
        color: @fg_color !important; 
      }

      headerbar { background-color: @sidebar_bg; color: @fg_color; }
      
      /* Selection fixes: ensure dark text on cyan background */
      selection,
      .selected,
      *:selected,
      treeview.view:selected,
      treeview.view:selected:focus { 
        background-color: @accent_color !important; 
        color: @bg_color !important; 
      }

      /* Ensure labels and icons inside selection are dark */
      selection label,
      .selected label,
      *:selected label,
      treeview.view:selected label,
      .selected row,
      .selected row label {
        color: @bg_color !important;
      }

      button { background-image: none; background-color: @button_bg; color: @fg_color; }
      button:hover { background-color: @button_hover; border-color: @accent_color; }
      button:checked { background-color: @accent_color; color: @bg_color; }
      
      /* Progress bars and switches in cyan */
      progressbar progress { background-color: @accent_color; }
      switch:checked { background-color: @accent_color; }
      check:checked, radio:checked { color: @accent_color; }
    '';
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.noctalia = {
    enable = true;
    # Você pode configurar opções do Noctalia diretamente aqui depois
  };
}