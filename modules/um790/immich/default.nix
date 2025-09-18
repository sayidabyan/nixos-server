{config, pkgs, ...}:
{
  services.immich = {
    enable = true;
    host = "100.112.119.112";
    mediaLocation = "/media/external/immich";
    package = pkgs.unstable.immich;
    accelerationDevices = [
      "/dev/dri/renderD129"
    ];
  };
  users.users.immich.extraGroups = [
    "render"
    "video"
  ]; # Access to /dev/dri
  services.nginx.virtualHosts."photos.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:${toString config.services.immich.port}";
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
