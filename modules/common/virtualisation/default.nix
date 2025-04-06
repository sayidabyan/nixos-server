{...}:

{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.sayid = {
    extraGroups = [ "podman" ];
  };
  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      distrobox
      docker-compose
    ];
  };
}
