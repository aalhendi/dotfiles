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

    "Aesthetics
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'gruvbox-community/gruvbox'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Fuzzy finder chad addon
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim' 
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    
    " Advanced parsing and highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update    
    
    "LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'simrat39/symbols-outline.nvim'

    " Prettier - post install (yarn install | npm install) then load plugin only for editing supported files
    Plug 'prettier/vim-prettier', {
        \ 'do': 'yarn install',
        \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }


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

