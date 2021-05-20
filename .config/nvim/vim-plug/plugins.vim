" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Colorscheme
    Plug 'gruvbox-community/gruvbox'
    " Fuzzy finder chad addon
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim' 
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    
    " Advanced parsing and highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update    
    
    " Debugger
    Plug 'puremourning/vimspector'
    Plug 'szw/vim-maximizer'
    
    " Git stuff
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    
    "Read man with viman
    Plug 'vim-utils/vim-man'
    
    " Undo Tree
    Plug 'mbbill/undotree'


call plug#end()

colorscheme gruvbox
highlight Normal guibg=none " background transparency

