{...}:
{
  fileSystems."/shared" = {
    device = "/media/external/shared";
    options = ["bind" "user" "rw"];
  };
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /shared  100.72.251.119(rw,nohide,insecure,no_subtree_check)
  '';
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
