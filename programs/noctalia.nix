{ config, pkgs, ... }:
{
  home-manager.users.drfoobar = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;

      settings = { # This may also be a string or path to a .toml file.
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = "/home/felps/Downloads/wallpap.jpg";
        };
      };
    };
  };
}