{...}:
{
  services.trilium-server = {
    enable = true;
    port = 3535;
    dataDir = "/media/external/trilium";
  };

  services.nginx.virtualHosts."notes.say.id" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:3535";
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
