{config, ...}:
{
  services.languagetool = {
    enable = true;
    public = true;
    allowOrigin = "*";
  };

  services.nginx.virtualHosts."lt.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:${toString config.services.languagetool.port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };
}
