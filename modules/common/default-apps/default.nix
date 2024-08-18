{ pkgs, ...}:
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs;[
      xdg-desktop-portal-gtk
    ];
  };
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  
  home-manager.users.sayid = {...}:{
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "kitty";
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs;[
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    xdg.mime.enable = true;
    xdg.mimeApps = {
      enable  =  true;
      defaultApplications = {
        "default-web-browser" = [ "brave-browser.desktop" ];
        "text/html" = [ "brave-browser.desktop" ];
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "text/nix" = [ "nvim.desktop" ];
      };
    };
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
