{...}:
{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/mnt/Data_D" = {
    device = "100.112.119.112:/shared";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
}
