{pkgs, ...}:
{
  services.n8n = {
    enable = true;
    settings = {
      listen_address = 5678;
      N8N_SECURE_COOKIE = false;
    };
  };
  systemd.services.n8n = {
    environment = {
      N8N_SECURE_COOKIE = "false";
    };
  };

  services.nginx.virtualHosts."n8n.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:5678";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 10000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}
