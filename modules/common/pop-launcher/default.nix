{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    pop-launcher
  ];
}
