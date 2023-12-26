{
  description = "sayid-nixos flake";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  # outputs = { self, nixpkgs, home-manager }: {
  # um790pro = [ 
  # nixpkgs.lib.nixosSystem{
  # modules = [
  #   ./configuration.nix
  #   home-manager.nixosModules.home-manager
  # ];
  outputs = inputs:
    let
      buildSystem = builtins.mapAttrs (device: modules:
        let
          nixpkgs = inputs.nixpkgs;
          home-manager = inputs.home-manager;
          lib = nixpkgs.lib;
          modulesInDir = dir: (lib.trivial.pipe dir [
            builtins.readDir
            (lib.attrsets.filterAttrs (key: val: val == "directory"))
            builtins.attrNames
            (builtins.map (name: dir + "/${name}"))
          ]);
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit device;
            username = "sayid";
          };
          modules =
            modulesInDir ./modules/common ++
            modulesInDir (./modules + "/${device}") ++
            [
              ({ pkgs, ... }: {
                nix = {
                  registry.nixpkgs.flake = nixpkgs;
                  settings.experimental-features = [ "nix-command" "flakes" ];
                };

                # Required for nixos-rebuild with flakes
                environment.systemPackages = [ pkgs.git ];
              })
              home-manager.nixosModules.home-manager
            ] ++ modules;
        }
      );
    in
    {
      nixosConfigurations = buildSystem {
        um790 = [ 
          inputs.nixos-hardware.nixosModules.common-gpu-amd
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
        ];
      };
    };
}
