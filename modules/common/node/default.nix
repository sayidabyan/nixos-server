{...}:
{
  home-manager.users.sayid = {pkgs, ...}:
  {
    home.packages = with pkgs; [
      deno
      nodejs_22
      typescript-language-server
    ];
  };
}
