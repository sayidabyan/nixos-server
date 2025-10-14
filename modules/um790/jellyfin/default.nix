{pkgs, ...}:
{
  services.jellyfin = {
    enable = true;
    package = pkgs.unstable.jellyfin;
    dataDir = "/media/external/jellyfin";
    openFirewall = true;
  };
  users.users.jellyfin.extraGroups = [
    "render"
    "video"
  ]; # Access to /dev/dri

  services.nginx.virtualHosts."media.say.id" = {
    default = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8096";
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
