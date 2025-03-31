{...}:
{
  home-manager.users.sayid = {pkgs, ...}:
  {
    home.packages = with pkgs; [
      nodejs_22
      typescript-language-server
    ];
  };
}
