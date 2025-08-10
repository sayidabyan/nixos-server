{config, pkgs, ...}:
{
  environment.etc."nextcloud-admin-pass".text = "sayidsayid";
  services.nextcloud = {
    enable = true;
    package = pkgs.stable.nextcloud31;
    home = "/media/external/nextcloud";
    maxUploadSize = "10G";
    hostName = "nix-nextcloud";
    configureRedis = true;
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    settings.trusted_domains = ["100.112.119.112" "nc.say.id"];   
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}" = {
    listen = [{
      addr = "100.112.119.112";
      port = 8080; # NOT an exposed port
    }];
  };

  services.nginx.virtualHosts."nc.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:8080";
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
