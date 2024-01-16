{pkgs, ...}:

{
  users.users.sayid.shell = pkgs.zsh;
  programs.zsh.enable = true;
  home-manager.users.sayid = { pkgs, ... }: {
    programs = {
        zsh = {
            enable = true;
            syntaxHighlighting.enable = true;
            enableCompletion = true;
            enableAutosuggestions = true;
            autocd = true;
            oh-my-zsh.enable = true;
            plugins = [
                {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
                }
            ];
            initExtraFirst = ''
                # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
                # Initialization code that may require console input (password prompts, [y/n]
                # confirmations, etc.) must go above this block; everything else may go below.
                if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                fi
            '';
            initExtra = ''
                # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
                [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
		
		export PYENV_ROOT="$HOME/.pyenv"
            '';
            shellAliases = {
                flake-update = "nix flake update ~/flake";
		enter-ubuntu = "distrobox-enter --additional-flags '--env PATH=\"$PYENV_ROOT/bin:$PATH\"' ubuntu-box";
            };
        };
    };
  };
}
