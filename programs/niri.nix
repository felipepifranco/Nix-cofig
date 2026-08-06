{ config, pkgs, ... }:

{
  programs.niri = {
  enable = true;
  settings = {
    prefer-no-csd = true;
    input.keyboard.xkb = {
      layout = "br";
    };
    layout = {
      gaps = 4;
      focus-ring = {
        enable = true;
        width = 2;
      };
    };

    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "swaybg" "-i" "/home/felps/Downloads/wallpap.jpg" "-m" "fill" ]; } 
    ];
    # 3. ATALHOS VITAIS DE SOBREVIVÊNCIA
binds = {
      # =========================================
      # 1. SOBREVIVÊNCIA (Os que você já tinha)
      # =========================================
      "Mod+Return".action.spawn = [ "kitty" ]; 
      "Mod+D".action.spawn = [ "fuzzel" ];         
      "Mod+Q".action.close-window = {};            
      "Mod+Shift+E".action.quit = {};              

      # =========================================
      # 2. MOVER O FOCO (De acordo com a Waybar)
      # =========================================
      # Navega entre as janelas sem movê-las de lugar
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Down".action.focus-window-down = {};

      # =========================================
      # 3. MOVER E TROCAR JANELAS (De acordo com a Waybar)
      # =========================================
      # Empurra a janela atual, trocando ela de posição com as outras
      "Alt+Left".action.move-column-left = {};
      "Alt+Right".action.move-column-right = {};
      # "Alt+Up".action.move-window-up = {};
      # "Alt+Down".action.move-window-down = {};

      # =========================================
      # 4. REDIMENSIONAR (Largura e Altura)
      # =========================================
      # Usa os botões de Menos (-) e Igual (=) perto do Backspace
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # =========================================
      # 5. DIVISÃO VERTICAL E FLUTUANTE
      # =========================================
      # Puxa a janela do lado para formar uma coluna dividida (uma em cima da outra)
      "Mod+C".action.consume-window-into-column = {};
      # Desfaz a divisão vertical, separando as janelas de volta para os lados
      "Mod+Shift+C".action.expel-window-from-column = {}; 
      # Transforma a janela em flutuante (conforme sua Waybar)
      "Mod+V".action.toggle-window-floating = {};

      # =========================================
      # 6. CAPTURA DE TELA E TELA CHEIA
      # =========================================
      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};
      # Modo foco: esconde o resto da "fita" e centraliza a janela atual
      "Mod+F".action.maximize-column = {}; 
      # Tela cheia absoluta (ótimo para vídeos ou máquinas virtuais)
      "Mod+Shift+F".action.fullscreen-window = {}; 
      "Mod+B".action.spawn = [ "pkill" "-SIGUSR1" "waybar" ]; # some com a barra

      # =========================================
      # 7. ÁREAS DE TRABALHO (Workspaces)
      # =========================================
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      
      # Envia a janela atual para outra área de trabalho
      "Alt+1".action.move-column-to-workspace = 1;
      "Alt+2".action.move-column-to-workspace = 2;
      "Alt+3".action.move-column-to-workspace = 3;
      "Alt+4".action.move-column-to-workspace = 4;
      "Alt+5".action.move-column-to-workspace = 5;
    
      
      # =========================================
      # 8. BOTÕES DE CONTROLE (DE F1 A F7)
      # =========================================
      # --- Controle de Volume ---
      "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "5%+" ];
      "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
      "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];

      # --- Controle de Mídia (Spotify, YouTube, etc) ---
      "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];

      # --- Controle de Brilho da Tela ---
      "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "5%+" ];
      "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "5%-" ];
    };
  };
};
}