{...}:
{
  services.resolved = {
    # Disable local DNS stub listener on 127.0.0.53
    extraConfig = ''
      DNSStubListener=no
    '';
  };
  users.users.pihole = {
    isSystemUser = true;
    uid = 4242;
    group = "pihole";
  };
  users.groups.pihole = {
    gid = 4242;
  };

  virtualisation.oci-containers.containers.pihole = {
    serviceName = "pihole";
    image = "pihole/pihole:latest";
    volumes = [ 
      "/media/external/pihole:/etc/pihole" 
      "/media/external/pihole/dnsmasq.d:/etc/dnsmasq.d"
    ];
    environment = {
      TZ = "Asia/Jakarta";
      FTLCONF_webserver_port = "8888o,[::]:8888o,8443os,[::]:8443os";
      PIHOLE_UID = "4242";
      PIHOLE_GID = "4242";
    };
    extraOptions = ["--network=host"];
    capabilities = {
      NET_ADMIN = true;
      CAP_SYS_TIME = true;
    };
  };
  services.nginx.virtualHosts."dns.say.id" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8888";
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
