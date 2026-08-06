{ config, pkgs, ...}:

{ 
  programs.kitty = {
    enable = true;
    font = {
      size = 12;
      name = "Hurmit Nerd Font";
    };
    settings = {
      allow_remote_control = "yes";
      background_opacity = 0.9;
    };
  };
}