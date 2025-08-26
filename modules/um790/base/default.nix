{pkgs, ...}:
{
# Mostly Radeon Related
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [rocmPackages.clr.icd];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelParams = [ 
    "amdgpu.ppfeaturemask=0xffffffff" # enable radeon oc control(?)
  ];

  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      lact
    ];
  };
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
}
