{...}:
{
  users.users.memos = {
    isSystemUser = true;
    uid = 5230;
    group = "memos";
  };
  users.groups.memos = {
    gid = 5230;
  };

  virtualisation.oci-containers.containers.memos = {
    serviceName = "memos";
    image = "neosmemo/memos:stable";
    # ports = [ "0.0.0.0:5230:5230" ];
    volumes = [ "/media/external/memos:/var/opt/memos" ];
    environment = {
      MEMOS_MODE = "prod";
      MEMOS_PORT = "5230";
    };
    user = "5230:5230";
    extraOptions = ["--network=host"];
  };
  services.nginx.virtualHosts."memos.say.id" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:5230";
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
