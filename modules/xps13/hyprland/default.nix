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
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 1920x1080@60, 0x0, 1"
        ];
        input = {
          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.5;
          };
        };
        gestures = {
          workspace_swipe = true;
        };
      };
    };
  };
}
