{...}:

{
  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };
}
