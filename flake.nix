{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; 

    home-manager = {
      url = "github:nix-community/home-manager/master"; # Use a mesma versão do seu nixpkgs
      inputs.nixpkgs.follows = "nixpkgs"; # Garante que ele use os mesmos pacotes do sistema
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg = {
        url = "github:pwndbg/pwndbg";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, pwndbg, ... }: {

    nixosConfigurations.felps = nixpkgs.lib.nixosSystem{ # meu nome de usuário
      system = "x86_64-linux";
      modules = [ # especificando os módulos
        ./configuration.nix 
        home-manager.nixosModules.home-manager
        {
          home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit pwndbg; }; #converir
              sharedModules = [ niri.homeModules.niri ];
              users.felps = ./home.nix;
          };
        }
      ]; 
    };
  };
}
