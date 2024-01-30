{ ... }:
{
    services.nfs.server.enable = true;
    services.nfs.server.exports = ''
        /etc/share 100.72.80.85 (rw,fsid=0,no_subtree_check)
    '';
}
