{
  description = "sayid-nixos flake";

    inputs = {
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:nixos/nixos-hardware/master";
        nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable";
        agenix = {
            url = "github:ryantm/agenix";
            inputs.darwin.follows = "";
        };
        aiken.url = "github:aiken-lang/aiken";
    };
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
            xps13 = [
                inputs.nixos-hardware.nixosModules.dell-xps-13-9370
            ];
        };
    };
}
