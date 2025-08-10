{...}:
{
  home-manager.users.sayid = {pkgs, ...}: {
    programs = {
      chromium = {
        enable = true;
        commandLineArgs = [ "--ozone-platform=wayland" ];
        package = pkgs.chromium.override { enableWideVine = true; };
      };
    };
  };
}
