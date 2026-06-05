{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; 

    home-manager = {
      url = "github:nix-community/home-manager/master"; # Use a mesma versão do seu nixpkgs
      inputs.nixpkgs.follows = "nixpkgs"; # Garante que ele use os mesmos pacotes do sistema
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {

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
              users.felps = ./home.nix;
          };
        }
      ]; 
    };
  };
}
