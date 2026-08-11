{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };

      window = {
        dimensions = {
          columns = 125;
          lines = 60;
        };
        padding = {
          x = 8;
          y = 0;
        };
        startup_mode = "Maximized";
        decorations = "None";
        opacity = 0.75;
      };

      font = {
        normal = {
          family = "Hack Nerd Font Mono";
        };
        size = 20;
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "Off";
        };
      };

      colors = {
        primary = {
          background = "#011319";
          foreground = "#b1bac4";
        };

        cursor = {
          text = "#011319";
          cursor = "#ffffff";
        };

        normal = {
          black   = "#0d1117";
          red     = "#fd8c73";
          green   = "#8ddb8c";
          yellow  = "#d29922";
          blue    = "#58a6ff";
          magenta = "#bc8cff";
          cyan    = "#39c5cf";
          white   = "#b1bac4";
        };

        bright = {
          black   = "#6e7681";
          red     = "#ff7b72";
          green   = "#56d364";
          yellow  = "#e3b341";
          blue    = "#79c0ff";
          magenta = "#d2a8ff";
          cyan    = "#56d364";
          white   = "#f0f6fc";
        };
      };
    };
  };
}