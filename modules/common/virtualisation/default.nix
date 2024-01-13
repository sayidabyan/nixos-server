{pkgs, ...}:

{  
    virtualisation.docker = {
        enable = true;
    };

    home-manager.users.sayid = { pkgs, ... }: {
        home.packages = with pkgs; [
            distrobox
        ];
    };
}
