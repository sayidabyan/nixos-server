{...}:
{
  services.qbittorrent = {
    enable = true;
    profileDir = "/media/external";
    webuiPort = 9091;
    user = "sayid";
    group = "users";
  };

  services.nginx.virtualHosts."torrent.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:9091";
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
