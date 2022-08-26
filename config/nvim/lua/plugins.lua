require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- themes
  use { 'tobi-wan-kenobi/zengarden-lush',
    requires = 'rktjmp/lush.nvim',
    config = function()
      vim.cmd [[ colorscheme zengarden-lush ]]
    end
  }
  use 'ryanoasis/vim-devicons'

  -- status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

  -- syntax, lsp, autocomplete, etc.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'j-hui/fidget.nvim'
  use 'neovim/nvim-lspconfig'
  use 'lvimuser/lsp-inlayhints.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  }
  use { 'lewis6991/hover.nvim', config = function()
    require('hover').setup({
      init = function()
        -- Require providers
        require('hover.providers.lsp')
        -- require('hover.providers.gh')
        --require('hover.providers.man')
        -- require('hover.providers.dictionary')
      end,
      preview_opts = {
        border = nil
      },
      title = true
    })
  end}

  -- finding and stuff
  use { 'gfanto/fzf-lsp.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  use 'lewis6991/gitsigns.nvim'
  use 'rhysd/git-messenger.vim'
  use 'f-person/git-blame.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- experimental
  use 'ellisonleao/glow.nvim'
  use 'numToStr/FTerm.nvim'
  use { 'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }


end)


require('nvim-treesitter.configs').setup({
	auto_install = true,
	highlight = {
		enable = true,
	}
})

vim.g.coq_settings = { auto_start = 'shut-up' }
require('coq')

require('gitsigns').setup()
vim.g.gitblame_enabled = false

require('glow').setup({
  width = 120,
  border = 'single'
})

local lualine_zengarden = require('lualine_zengarden')
require('lualine').setup({
  icons_enable = true,
  options = { theme = lualine_zengarden },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {'diagnostics', 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },

	tabline = {
		lualine_a = {'buffers'},
		lualine_z = {'tabs'}
	}
})

require('nvim-lightbulb').setup({autocmd = {enabled = true}})
require('nvim-tree').setup()
vim.g.git_messenger_floating_win_opts = { border = 'single' }

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
]])

vim.cmd([[
set undofile
set undodir=~/.local/share/nvim/undo/
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
]])
