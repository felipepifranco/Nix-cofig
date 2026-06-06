{ config, pkgs, ...}:

let 
  dir = ./programs;
in
{
  imports = [
    (dir + "/bash.nix")
    (dir + "/alacritty.nix")
    (dir + "/git.nix")
    (dir + "/niri.nix")
    ./waybar/default.nix
  ];

  home.username = "felps";
  home.homeDirectory = "/home/felps";
  home.stateVersion = "25.11";
}