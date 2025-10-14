{ inputs, pkgs, ...}:
{
  imports = [
    (inputs.nixpkgs-unstable + "/nixos/modules/services/misc/memos.nix")
  ];

  services.postgresql.enable = true;
  services.memos = {
    enable = true;
    package = pkgs.unstable.memos;
    dataDir = "/media/external/memos";
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
