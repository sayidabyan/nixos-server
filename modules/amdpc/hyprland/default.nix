{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "DP-1, /home/sayid/nixos/bg/path less traveled.jpg"
          "DP-2, /home/sayid/nixos/bg/path less traveled.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "DP-1, 2560x1440@144, 0x583, 1"
          "DP-2, 2560x1440@60, 2560x0, 1, transform, 3"
        ];

        "$mainMod" = "ALT";
        "$mainMod2" = "SUPER";
      };
    };
  };
}
