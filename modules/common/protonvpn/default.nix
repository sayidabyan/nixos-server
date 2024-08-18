{...}:
{
    home-manager.users.sayid = {pkgs, ...}: {
        home.packages = with pkgs; [
	        protonvpn-gui
          protonvpn-cli
	    ];
    };
}
