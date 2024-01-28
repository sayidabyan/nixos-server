{...}:

{
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
            temurin-bin-11
	    maven
	    eclipses.eclipse-java
        ];
    };
}
