{...}:
{
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extest.enable = true;
  };
  boot.kernelModules = [ "uinput" ];
}
