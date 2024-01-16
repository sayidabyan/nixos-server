{pkgs, ...}:

{  
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
            conda
	    python312
            python312Packages.pip
        ];
    };
}
