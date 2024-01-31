local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- plugins here
  use 'ThePrimeagen/vim-be-good'
  use{
	  'nvim-telescope/telescope.nvim', tag='0.1.3', 
	  --or , branch='0.1.x',
	  requires = {{ 'nvim-lua/plenary.nvim' }}
  }
  
  use({
	  'NLKNguyen/papercolor-theme',
	  as = 'papercolor-theme',
	  config = function()
		  vim.cmd('colorscheme PaperColor')
		  vim.cmd('set number')
		  vim.cmd('set laststatus=2')
	  end

  })

  --[[use({
	  'projekt0n/github-nvim-theme',
	  vim.cmd('colorscheme github_dark_dimmed')
  })]]

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')

  --[[use{
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires ={
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},
	  	{'neovim/nvim-lspconfig'},

		{'hrsh7th/nvim-cmp'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-nvim-lua'},
		{'saadparwaiz1/cmp_luasnip'},

		{'L3MON4D3/LuaSnip'},
		{'rafamadriz/friendly-snippets'},
	  }
  }]]

  use{
	'neovim/nvim-lspconfig',
	requires = {
		{'williamboman/mason.nvim', config = true},
		{'williamboman/mason-lspconfig.nvim'},
	}
  }

  use{
	'hrsh7th/nvim-cmp',
	requires={
		{'L3MON4D3/LuaSnip'},
		{'saadparwaiz1/cmp_luasnip'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-nvim-lua'},
		{'rafamadriz/friendly-snippets'},
	}
  }


  --
  if packer_bootstrap then
    require('packer').sync()
  end
end)
