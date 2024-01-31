{ ... }:
{
    services.nfs.server.enable = true;
    services.nfs.server.exports = ''
    /etc/share  100.72.80.85(rw,nohide,insecure,no_subtree_check)
    '';
}
