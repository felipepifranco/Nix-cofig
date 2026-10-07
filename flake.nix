{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";

      inputs.xwayland-satellite-unstable.url =
      "github:Supreeeme/xwayland-satellite";
    };

    pwndbg = {
      url = "github:pwndbg/pwndbg";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wlctl = {
      url = "github:aashish-thapa/wlctl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      niri,
      pwndbg,
      wlctl,
      noctalia,
      ...
    }:
    {
      nixosConfigurations.felps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                inherit pwndbg wlctl;
              };

              sharedModules = [
                niri.homeModules.niri
                noctalia.homeModules.default
              ];

              users.felps = ./home.nix;
            };
          }
        ];
      };
    };
}