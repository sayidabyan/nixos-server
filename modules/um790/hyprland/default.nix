{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "HDMI-A-1, /home/sayid/nixos/bg/Path Less Traveled.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "HDMI-A-1, 1920x1080@144, 0x0, 1"
        ];

        "$mainMod" = "ALT";
        "$mainMod2" = "SUPER";
      };
    };
  };
}
