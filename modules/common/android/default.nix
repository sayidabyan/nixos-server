{inputs, ...}:

{
    home-manager.users.sayid = {config, lib, pkgs, ...}: {
        home.packages = with pkgs; [
            android-studio
            android-tools
        ];
    };
}
