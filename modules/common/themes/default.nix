{...}:

{
    home-manager.users.sayid = { pkgs, ... }: {
        fonts.fontconfig.enable = true;
        gtk = {
            enable = true;
            # font.name = "BlexMono Nerd Font";
            iconTheme = {
                name = "Papirus";
                package = pkgs.papirus-icon-theme;
            };
            cursorTheme = {
                name = "Bibata-Modern-Ice";
                package = pkgs.bibata-cursors;
                size = 24;
            };
            theme = {
                name = "rose-pine";
                package = pkgs.rose-pine-gtk-theme;
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
            platformTheme.name = "gtk";
            style.name = "gtk2";
        };
        dconf.settings = {
            "org/gnome/desktop/background" = {
                picture-uri-dark = "/home/sayid/nixos/bg/Sakura Festival.jpg";
            };
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };
    };
}
