{...}:
{
  home-manager.users.sayid = {pkgs, ...}:
  {
    home.packages = with pkgs; [
      go
      gopls
      govulncheck
    ];
  };
}
