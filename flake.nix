{
  description = "sayid-nixos flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    editor-integration-nvim = {
      url = "github:aiken-lang/editor-integration-nvim";
      flake = false;
    };
    winresizer-vim = {
      url = "github:simeji/winresizer";
      flake = false;
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
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
              {
                # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
                nix.registry.nixpkgs.flake = inputs.nixpkgs;
                nixpkgs.overlays = [
                  (final: prev: {
                    stable = import inputs.nixpkgs-stable {
                      system = final.system;
                      config.allowUnfree = true;
                    };
                    unstable = import inputs.nixpkgs-unstable {
                      system = final.system;
                      config.allowUnfree = true;
                    };
                    bleeding = import inputs.nixpkgs-bleeding {
                      system = final.system;
                      config.allowUnfree = true;
                    };
                    vimPlugins =
                      let
                        vimPlugin = name: final.vimUtils.buildVimPlugin {
                          name = name;
                          src = inputs.${name};
                        };
                      in
                      prev.vimPlugins // {
                        editor-integration-nvim = vimPlugin "editor-integration-nvim";
                        winresizer-vim = vimPlugin "winresizer-vim";
                      };
                  })
                ];
              }
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
