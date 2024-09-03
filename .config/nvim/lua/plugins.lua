packer = require('packer')
packer.init {
    opt_default = false,
}

local use = packer.use
packer.reset()

packer.startup(function()

  use {
    'wbthomason/packer.nvim',
    opt = false
 }

  -- A better status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- File management --
  use 'vifm/vifm.vim'
  use 'scrooloose/nerdtree'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'ryanoasis/vim-devicons'
  use "nvim-lua/plenary.nvim"

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- Productivity --
  use 'vimwiki/vimwiki'
  use 'jreybert/vimagit'

  -- Tim Pope Plugins --
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'

  -- Syntax Highlighting and Colors --
  use 'PotatoesMaster/i3-vim-syntax'
  use 'kovetskiy/sxhkd-vim'
  use 'vim-python/python-syntax'
  use 'ap/vim-css-color'
  use 'https://gitlab.com/__tpb/monokai-pro.nvim'

  -- Junegunn Choi Plugins --
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'junegunn/vim-emoji'

  -- Colorschemes
  use 'RRethy/nvim-base16'
  use 'kyazdani42/nvim-palenight.lua'

  -- Other stuff
  use 'frazrepo/vim-rainbow'
  use 'https://github.com/tc50cal/vim-terminal'
  use 'nvim-treesitter/nvim-treesitter' --, {'do': ':TSUpdate'}

  -- Languages syntax
  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
end)
