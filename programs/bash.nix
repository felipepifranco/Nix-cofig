{ config, pkgs, ... }:
{
  programs.bash ={
    enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch";
      btw = "echo uso o nixos, btw";
      config = "cd /etc/nixos";
   };
  };
}