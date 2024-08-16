{...}:
{
  home-manager.users.sayid = {...}: {
    programs.kitty = {
      enable = true;
      font.name = "Firacode Nerd Font";
      settings = {
        background_opacity = "0.8";
      };
      shellIntegration.enableZshIntegration = true;
      extraConfig = ''
        linux_display_server x11
      '';
    };
  };
}
