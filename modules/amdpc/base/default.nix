{config, pkgs, ...}:
{
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope.enable = true;
  # Mostly Radeon Related
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.unstable.mesa;
    extraPackages = with pkgs; [
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      unstable.lact
      protonup-qt
      steam-rom-manager
    ];
  };
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.unstable.lact}/bin/lact daemon";
    };
    enable = true;
  };
  services.power-profiles-daemon.enable = true;
}
