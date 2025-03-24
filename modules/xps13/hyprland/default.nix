{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "eDP-1, /home/sayid/nixos/bg/Sakura Festival.jpg"
        ];
      };
    };


    programs.waybar = {
      settings = {
        battery = {
          bat = "BAT0";
        };
      };
    };

    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 1920x1080@60, 0x0, 1"
        ];

        "$mainMod" = "ALT";
        "$mainMod2" = "SUPER";

        render = {
          explicit_sync = 0;
          explicit_sync_kms = 0;
        };
      };
    };
  };
}
