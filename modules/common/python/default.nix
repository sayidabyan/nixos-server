{pkgs, ...}:

{  
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
            conda
	    python311
            python311Packages.pip
	    python311Packages.python-lsp-server
        ];
    };
}
