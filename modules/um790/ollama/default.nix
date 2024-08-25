{ pkgs, ... }:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
      acceleration = "rocm";
      environmentVariables = {
        HSA_OVERRIDE_GFX_VERSION="11.0.0";
      };
    };
    open-webui = {
      enable = true;
      package = pkgs.unstable.open-webui;
      host = "100.112.119.112";
      port = 3000;
    };
  };
}
