{...}:
{
  home-manager.users.sayid = {...}: {
    # App Launcher
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "/home/sayid/.nix-profile/bin/kitty";
          font = "Quicksand:weight=medium:size=12";
          icon-theme = "Papirus-Dark";
        };
        colors = {
          background="00000099";
          text="c6d0f5ff";
          match="8caaeeff";
          selection="737994ff";
          selection-text="c6d0f5ff";
          selection-match="8caaeeff";
          border="b5bfe2ff";
        };
        border={
          width=2;
          radius=0;
        };
      };
    };

    wayland.windowManager.hyprland.settings.layerrule = [
      "blur, launcher"
    ];
  };
}
