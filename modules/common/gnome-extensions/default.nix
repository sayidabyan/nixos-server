{pkgs, ...}:

{
    environment.systemPackages = with pkgs.gnomeExtensions; [
        pop-shell
        dash-to-dock
        user-themes
        clipboard-indicator
        freon
        app-menu-is-back
        caffeine
    ];
    
    home-manager.users.sayid = { ... }: {
        dconf.settings = {
            "org/gnome/shell/extensions/pop-shell" = {
                hint-color-rgba = "rgba(173,200,95,1)";
            };
        };
    };
}
