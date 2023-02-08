-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	    -- Packer can manage itself
	    use 'wbthomason/packer.nvim'
	    use {
	        'nvim-telescope/telescope.nvim', tag = '0.1.1',
	        -- or                            , branch = '0.1.x',
	        requires = { { 'nvim-lua/plenary.nvim' } }
	    }
	    use({
	        'rose-pine/neovim',
	        as = 'rose-pine',
	        config = function()
		        require("rose-pine").setup()
		        vim.cmd('colorscheme rose-pine')
	        end
	    })
	    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	    use('nvim-treesitter/playground')
	    use('theprimeagen/harpoon')
	    use('mbbill/undotree')
	    use('tpope/vim-fugitive')
	    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
	    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
	    use 'hrsh7th/nvim-cmp' -- Completion
	    use 'windwp/nvim-autopairs'
	    use 'windwp/nvim-ts-autotag'


	    -- LSP
	    use 'onsails/lspkind-nvim' -- vscode-like pictograms
	    use 'neovim/nvim-lspconfig' -- LSP
	    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	    use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
	    use 'williamboman/mason.nvim'
	    use 'williamboman/mason-lspconfig.nvim'
	    use 'princejoogie/tailwind-highlight.nvim'
	    use 'glepnir/lspsaga.nvim' -- LSP UIs
	    use 'L3MON4D3/LuaSnip'


	    -- Toggle Terminal
	    use 'akinsho/toggleterm.nvim'
	    use {
	        'nvim-lualine/lualine.nvim',
	        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	    } -- statusline
	    use { "nvim-telescope/telescope-file-browser.nvim" }
    end)
