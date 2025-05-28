{config, pkgs, ...}:
let
  lact_pkg = pkgs.callPackage ./lact.nix {};
in
{
# Changed to AMD
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  environment.systemPackages = with pkgs; [
    (lact_pkg)
  ];

  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${lact_pkg}/bin/lact daemon";
    };
    enable = true;
  };

  services.power-profiles-daemon.enable = true;
}
