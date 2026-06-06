{ pkgs, inputs, ... }:

{
  home.file.".config/waybar/nixos.svg".source = ./nixos.svg;
  home.file.".config/waybar/config.jsonc".source = ./config.jsonc;

  programs.waybar = {
  
    enable = true;

    style = builtins.readFile ./style.css;

  };
}