{...}:
{
  programs.tmux = {
    enable = true;
    escapeTime = 10; # mainly for neovim
    terminal = "xterm-256color";
    keyMode = "vi";
    extraConfigBeforePlugins = ''
      # Turn mouse mode
      set -g mouse on
    '';
  };
}
