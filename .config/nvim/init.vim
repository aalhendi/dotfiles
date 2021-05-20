" Load Plugins file
source $HOME/.config/nvim/vim-plug/plugins.vim

" nvim Settings
set encoding=utf-8 "on by default
syntax on "on by default
set guicursor= "Fat cursor
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set cmdheight=2 "More space to display images
set updatetime=50 "Shorter update times
set nohlsearch "Dont highlight searches
set hidden "Keep buffer without saving it in background
set noerrorbells "NO ERROR BELLS
set nowrap "Dont wrap long text into newline
set nu rnu " relative line numbering
set clipboard=unnamed " public copy/paste register
set noswapfile " doesn't create swap files
set nobackup
set undodir=$HOME/.config/nvim/undodir
set undofile
set incsearch "incremental search
set wildmenu "graphical auto complete menu
set lazyredraw "redraws the screne when it needs to
set showmatch "highlights matching brackets
set scrolloff=8 "Keep an 8 line window when scrolling down
set signcolumn=yes "extra column for linting
set colorcolumn=80 "80 columns is a lil overkill. callback hell
set completeopt=menuone,noinsert,noselect
