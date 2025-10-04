{...}:
{
  users.users.siyuan = {
    isNormalUser = false;
    uid = 6806;
  };
  users.groups.siyuan = {
    gid = 6806;
    members = ["siyuan"];
  };
  virtualisation.oci-containers.containers.siyuan = {
    image = "b3log/siyuan";
    environment = {
      TZ = "Asia/Jakarta";
      PUID = "6806";
      PGID = "6806";
      SIYUAN_ACCESS_AUTH_CODE_BYPASS = "true";
      SIYUAN_WORKSPACE_PATH = "/siyuan/workspace";
    };
    volumes = [
      "/media/external/siyuan/workspace:/siyuan/workspace:rw"
    ];
    ports = [
      "100.112.119.112:6806:6806/tcp"
    ];
    user = "siyuan:siyuan";
  };

  services.nginx.virtualHosts."notes.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:6806";
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
