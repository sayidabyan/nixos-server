{pkgs, ...}:
{
# Mostly Radeon Related
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [rocmPackages.clr.icd];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}
