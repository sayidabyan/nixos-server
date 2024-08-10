{...}:
{
  home-manager.users.sayid = {...}: {
    programs.kitty = {
      enable = true;
      font.name = "Firacode Nerd Font";
      shellIntegration.enableZshIntegration = true;
      extraConfig = ''
        linux_display_server x11
      '';
    };
  };
}
