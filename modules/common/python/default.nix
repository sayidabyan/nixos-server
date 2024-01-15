{pkgs, ...}:

{  
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
            python312
            python312Packages.pip
        ];
    };
}
