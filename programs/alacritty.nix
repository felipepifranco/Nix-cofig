{ config, pkgs, ...}:

{ 
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font = {
        size = 16;
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
      };
    };
  };
}