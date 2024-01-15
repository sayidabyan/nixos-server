{pkgs, ...}:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    pop-shell
    dash-to-dock
    user-themes
    clipboard-indicator
  ];
}
