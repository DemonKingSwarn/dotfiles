-- Enable true color
if vim.fn.has("nvim") == 1 then
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end

-- Enable termguicolors
if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- Install Plugged if not already installed
local data_dir = vim.fn.has('nvim') == 1 and vim.fn.stdpath('data') .. '/site' or '~/.local/share/nvim'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) > 0 then
  vim.cmd('silent !curl -fLo ' .. data_dir .. '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

-- Configure plugins with vim-plug
vim.cmd [[
  call plug#begin(expand('~/.local/share/nvim/plugged'))
  Plug 'dracula/vim', { 'as': 'dracula' }
  " Plug 'comfysage/evergarden'
  Plug 'andweeb/presence.nvim'
  "Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'neovim/nvim-lspconfig'
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'gpanders/nvim-parinfer'
  Plug 'mfussenegger/nvim-dap'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'sioodmy/sixelpreview.nvim'
  call plug#end()
]]

-- UI Settings
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd('colorscheme dracula')
vim.opt.background = 'dark'
vim.g.nord_cursor_line_number_background = 1
vim.g.nord_uniform_diff_background = 1
vim.cmd('highlight VertSplit ctermbg=NONE guibg=NONE')
vim.g.airline_theme = 'dracula'

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.mouse = 'a'

-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Function to check for backspace
local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Auto fcitx settings
vim.g.input_toggle = 1

local function fcitx2en()
  local input_status = vim.fn.system("fcitx-remote")
  if input_status == '2\n' then
    vim.g.input_toggle = 1
    vim.fn.system("fcitx-remote -c")
  end
end

local function fcitx2zh()
  local input_status = vim.fn.system("fcitx-remote")
  if input_status ~= '2\n' and vim.g.input_toggle == 1 then
    vim.fn.system("fcitx-remote -o")
    vim.g.input_toggle = 0
  end
end

vim.opt.ttimeoutlen = 150

-- Autocommands for fcitx
vim.api.nvim_create_autocmd("InsertLeave", { callback = fcitx2en })
vim.api.nvim_create_autocmd("InsertEnter", { callback = fcitx2zh })
