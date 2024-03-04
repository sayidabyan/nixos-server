{inputs, ...}:

{
	home-manager.users.sayid = { pkgs, ... }: {
		imports = [inputs.nixvim.homeManagerModules.nixvim];
		home.packages = with pkgs; [
			ripgrep
		];
		programs.nixvim = {
			enable = true;
			enableMan = true;
			colorschemes.tokyonight.enable = true;
			clipboard = {
				providers.wl-copy.enable = true;
				register = "unnamedplus";
			};
			globals = {
				mapleader = " ";
				maplocalleader = " ";
			};
			keymaps = [
				{
					action = ":Telescope harpoon marks<CR>";
					key = "<C-h>";
				}
			];
			options = {
				relativenumber = true;
				tabstop = 4;
				softtabstop = 4;
				shiftwidth = 4;
				expandtab = true;
				smartindent = true;
			};
            extraPackages = with pkgs; [
                vimPlugins.flutter-tools-nvim
                vimPlugins.plenary-nvim
            ];
			plugins = {
				harpoon = {
					enable = true;
					enableTelescope = true;
				};
				lualine = {
					enable = true;
					iconsEnabled = true;
				};
				lsp = {
					enable = true;
					servers = {
						pylsp.enable = true;
						nixd.enable = true;
						html.enable = true;
						lua-ls.enable = true;
						cssls.enable = true;
						bashls.enable = true;
                        java-language-server.enable = true;
					};
				};
				# Cmp
				cmp-nvim-lsp.enable = true;
				cmp_luasnip.enable = true;
				cmp-omni.enable = true;
				cmp-pandoc-nvim.enable = true;
				cmp-pandoc-references.enable = true;
				cmp-path.enable = true;
				cmp-rg.enable = true;
				cmp-snippy.enable = true;
				cmp-spell.enable = true;
				# cmp-tmux.enable = true;
				cmp-treesitter.enable = true;
				cmp-vim-lsp.enable = true;
				cmp-vimwiki-tags.enable = true;
				cmp-vsnip.enable = true;
				cmp-zsh.enable = true;
				nvim-cmp = {
					enable = true;
					snippet.expand = "luasnip";
					mappingPresets = ["insert"];
					sources = [
						{name = "nvim_lsp";}
						{name = "luasnip"; }
						{name = "buffer"; }
						{name = "path"; }
					];
					mapping = {
						"<Tab>" = "cmp.mapping.confirm({ select = true })";
					};
				};
				nvim-tree.enable = true;
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
				treesitter = {
					enable = true;
					ensureInstalled = "all";
				};
				# auto-save.enable = true;
				gitsigns.enable = true;
				lsp-format.enable = true;
				markdown-preview.enable = true;
				nvim-colorizer.enable = true;
			};
			extraConfigLua = ''
				-- Telescope
				vim.keymap.set('n', '<leader>/', function()
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
				end, { desc = '[/] Fuzzily search in current buffer' })
				-- Nvim-tree
				vim.keymap.set('n', '<C-b>', require('nvim-tree.api').tree.toggle)
				-- Harpoon
					vim.keymap.set('n', '<leader>hl', require('harpoon.ui').nav_next)
					vim.keymap.set('n', '<leader>hh', require('harpoon.ui').nav_prev)
				vim.keymap.set('n', '<leader>hm', require('harpoon.mark').toggle_file)
				vim.keymap.set('n', '<leader>ha', require('harpoon.mark').clear_all)
                -- Jump to definition/declaration
                vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
			'';
		};
	};
}

