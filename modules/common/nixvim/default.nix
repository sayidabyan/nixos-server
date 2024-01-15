{inputs, ...}:

{
    home-manager.users.sayid = { ... }: {
        imports = [inputs.nixvim.homeManagerModules.nixvim];
        programs.nixvim = {
            enable = true;
            enableMan = true;
            colorschemes.catppuccin = {
                enable = true;
                flavour = "mocha";
            };
            clipboard.providers.wl-copy.enable = true;
            plugins = {
                telescope.enable = true;
                treesitter.enable = true;
            };
        };
    };
}