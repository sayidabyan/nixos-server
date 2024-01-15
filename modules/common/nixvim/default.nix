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
            clipboard = {
                providers.wl-copy.enable = true;
                register = [ "unnamed" "unnamedplus" ];
            };
            globals = {
                mapleader = " ";
                maplocalleader = " ";
            };
            plugins = {
	        lsp = {
		    enable = true;
                    servers = {
                        pylsp.enable = true;
		    };
		};
		nvim-cmp.enable = true;
                telescope = {
                    enable = true;
                    keymaps = {
                        "<leader>ff" = {
                           action = "find_files";
                           desc = "Find Files"; 
                        };
                        "<leader>gf" = {
                           action = "git_files";
                           desc = "Git Files"; 
                        };
                    };
                };	        
                treesitter.enable = true;
		harpoon.enable = true;
		gitsigns.enable = true;
            };
        };
    };
}
