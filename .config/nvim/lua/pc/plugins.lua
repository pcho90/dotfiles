-- Auto Install Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand for :PackerSync or :PackerCompile on save
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use protected call to prevent error on first use
local ok, packer = pcall(require, 'packer')
if not ok then
  vim.notify('~ Packer Call Error!')
  return
end

-- Use popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
  },
}

return require('packer').startup(function(use)
  -- Main --
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'

  -- Completion --
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use "hrsh7th/cmp-nvim-lsp"
  use 'hrsh7th/cmp-nvim-lua'

  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- LSP --
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'RRethy/vim-illuminate'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Treesitter --
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- tpope --
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'

  -- Telescope --
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Colors --
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
