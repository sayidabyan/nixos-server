{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "HDMI-A-2, /home/sayid/nixos/bg/Sakura Festival.jpg"
          "DP-1, /home/sayid/nixos/bg/Sakura Festival.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "HDMI-A-2, 2560x1440@60, 2560x0, 1"
          "DP-1, 2560x1440@144, 0x0, 1"
          "Unknown-1, disable"
        ];
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];
#        render = {
#          explicit_sync = true;
#        };
      };
    };
  };
}
