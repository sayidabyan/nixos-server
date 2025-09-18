{...}:
{
    services.tailscale.enable = true;
    networking.firewall.checkReversePath = "loose";

    services.zerotierone = {
      enable = true;
      port = 9994;
      joinNetworks = ["9e1948db638bcdb0"];
    };
}
