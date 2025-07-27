{pkgs, ...}:
{
  services.searx = {
    enable = true;
    package = pkgs.unstable.searxng;
    redisCreateLocally = true;
    environmentFile = /home/sayid/.secrets/.searxng.env;
    settings = {
      # Server configuration
      server = {
        base_url = "http://search.say.id";
        port = 8888;
        bind_address = "100.112.119.112";
        general = {
          debug = false;
        };
      };
      search = {
        formats = ["html" "json"];
      };
    };
  };

  services.nginx.virtualHosts."search.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:8888";
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
