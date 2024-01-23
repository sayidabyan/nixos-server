{...}:

{
  home-manager.users.sayid = { ... }: {
    programs = {
        zsh = {
            shellAliases = {
                nixos-upgrade = "sudo nixos-rebuild switch --flake ~/nixos#um790";
            };
        };
    };
  };
}
