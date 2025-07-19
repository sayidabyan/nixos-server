{config, pkgs, ...}:
{
  # Steam
  programs.steam = {
    enable = true;
    package = pkgs.steam;
  };
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope;
  };
  programs.gamemode = {
    enable = true;
    settings = 
    {
      general = {
        renice = 10;
      };

      # Warning: GPU optimisations have the potential to damage hardware
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  boot.kernelParams = [ 
    "amdgpu.ppfeaturemask=0xffffffff" # enable radeon oc control(?)
    # fix nic/ethernet issue (?)
    "pcie_port_pm=off"
    "pcie_aspm.policy=performance"
  ];

  # Mostly Radeon Related
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.unstable.mesa;
    extraPackages = with pkgs; [rocmPackages.clr.icd];
  };
  chaotic.mesa-git.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      unstable.lact
      protonup-qt
      steam-rom-manager
      unigine-heaven
      unigine-superposition
      mangohud
    ];
  };
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
