{inputs, config, ...}:
let
  system = config.system;
in
{
  home-manager.users.sayid = {...}: {
    home.packages = [
      inputs.zen-browser.packages."x86_64-linux".default
    ];
  };
}
