{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Felps";
    userEmail = "felipe.pifranco1@gmail.com";
  };
}

