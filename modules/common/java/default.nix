{pkgs, ...}:

{
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
            temurin-bin-11
	    temurin-jre-bin-11
	    maven
        ];
    };
}
