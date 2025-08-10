{...}:
{
  home-manager.users.sayid = {...}:
 {
    programs.tmux = {
      enable = true;
      escapeTime = 10; # mainly for neovim
      terminal = "xterm-256color";
      keyMode = "vi";
      mouse = true;
      newSession = true;
      extraConfig = ''
        set-option -g set-clipboard on
      '';
    };
  };
}
