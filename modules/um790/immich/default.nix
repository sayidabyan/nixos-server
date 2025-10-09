{config, pkgs, ...}:
{
  services.immich = {
    enable = true;
    host = "127.0.0.1";
    mediaLocation = "/media/external/immich";
    package = pkgs.unstable.immich;
    accelerationDevices = null;
  };
  users.users.immich.extraGroups = [
    "render"
    "video"
  ]; # Access to /dev/dri

  services.nginx.virtualHosts."photos.say.id" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.immich.port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}
