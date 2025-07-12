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
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      unstable.lact
      protonup-qt
      steam-rom-manager
      unigine-heaven
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

  # udev rules for dualsense
  services.udev.extraRules = ''
    # PS5 DualSense controller over USB hidraw
    ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  # Enable firmware regardless of licenses
  hardware.enableAllFirmware = true;
}
