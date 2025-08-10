{pkgs, ...}:
{
  services.open-webui = {
    enable = true;
    host = "100.112.119.112";
    package = pkgs.open-webui;
    port = 8081;
    environment = {
      OLLAMA_API_BASE_URL= "http://ollama.say.id";
    };
  };
  services.nginx.virtualHosts."chat.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:8081";
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
