{inputs, pkgs, ...}:

{
    home-manager.users.sayid = { pkgs, ... }: {
        imports = [inputs.nixvim.homeManagerModules.nixvim];
        home.packages = with pkgs; [
	    ripgrep
	];
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
			"<leader>lg" = {
			    action = "live_grep";
			    desc = "Live Grep";
			};
                    };
                };
		toggleterm = {
		    enable = true;
		    direction = "float";
		    openMapping = "<C-t>";
		};
                treesitter.enable = true;
		harpoon.enable = true;
		gitsigns.enable = true;
            };
	    extraConfigLua = ''
	        vim.keymap.set('n', '<leader>/', function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		    winblend = 10,
		    previewer = false,
		})
		end, { desc = '[/] Fuzzily search in current buffer' })
	    '';
        };
    };
}
