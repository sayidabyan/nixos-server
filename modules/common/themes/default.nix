{ pkgs, ... }:

{
    home-manager.users.sayid = { pkgs, ... }: {
        #   home.pointerCursor = {
        #     gtk.enable = true;
        #     package = pkgs.numix-cursor-theme;
        #     name = "Numix-Cursor";
        #   };
        gtk = {
            enable = true;
            iconTheme = {
                name = "Papirus";
                package = pkgs.papirus-icon-theme;
            };
            cursorTheme = {
                name = "Numix-Cursor";
                package = pkgs.numix-cursor-theme;
                size = 24;
            };
            theme = {
                name = "Matcha-dark-pueril";
                package = pkgs.matcha-gtk-theme.override { 
                    colorVariants = ["dark"];
                    themeVariants = ["pueril"];
                };
            };
            gtk3.extraConfig = {
                Settings = ''
                    gtk-application-prefer-dark-theme=1
                    '';
            };
            gtk4.extraConfig = {
                Settings = ''
                    gtk-application-prefer-dark-theme=1
                    '';
            };
        };
        qt = {
            enable = true;
            platformTheme = "gtk";
            style.name = "gtk2";
        };
        #   dconf.settings = {
        #     "org/gnome/desktop/interface" = {
        #       color-scheme = "prefer-dark";
        #     };
        #   };
    };
}
