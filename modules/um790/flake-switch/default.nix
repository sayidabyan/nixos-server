{...}:

{
  home-manager.users.sayid = { ... }: {
    programs = {
        zsh = {
            shellAliases = {
                flake-switch = "sudo nixos-rebuild switch --flake ~/flake#um790";
            };
        };
    };
  };
}
