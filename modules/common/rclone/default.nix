{pkgs, ...}:
{
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      rclone
    ];
  };
}
