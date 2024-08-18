{...}:
{
  home-manager.users.sayid = {...}: {
    home.file.".config/kitty/current-theme.conf" = {
      source = ./. + "/Rosé\ Pine\ Moon.conf";
      recursive = true;
    };
    programs.kitty = {
      enable = true;
      font.name = "Firacode Nerd Font";
      settings = {
        background_opacity = "0.8";
      };
      environment = {
        "KITTY_ENABLE_WAYLAND" = "1";
      };
      extraConfig = ''
        # BEGIN_KITTY_THEME
        # Rosé Pine Moon
        include current-theme.conf
        # END_KITTY_THEME%      
      '';
      shellIntegration.enableZshIntegration = true;
    };
  };
}
