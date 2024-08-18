{pkgs,...}:

{
  environment.systemPackages = with pkgs; [
    rose-pine-icon-theme
    rose-pine-gtk-theme
    bibata-cursors
  ];

  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      rose-pine-icon-theme
      rose-pine-gtk-theme
      bibata-cursors
    ];
  };
}
