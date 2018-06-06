call plug#begin('~/.config/nvim/plugged')

" Plugins {
    Plug 'neomake/neomake'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'taohex/lightline-buffer'
    Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeTabsToggle'] }
    Plug 'jistr/vim-nerdtree-tabs', { 'on': ['NERDTreeToggle', 'NERDTreeTabsToggle'] }
    Plug 'morhetz/gruvbox'
    Plug 'mileszs/ack.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'majutsushi/tagbar'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Yggdroot/indentLine'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Raimondi/delimitMate'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Konfekt/FastFold'
    Plug 'kopischke/vim-stay'
    Plug 'editorconfig/editorconfig-vim'

    Plug 'fatih/vim-go'
    Plug 'gorodinskiy/vim-coloresque'
    Plug 'mattn/emmet-vim'

" }
call plug#end()

" LEADER
let mapleader=","

" LANGUAGES


" SETTINGS

" General {
    set noautoindent        " I indent my code myself.
    set nocindent           " I indent my code myself.
    set timeoutlen=1000 ttimeoutlen=0 " Eliminating delays on ESC
" }

" Search {
    nmap <Leader>s :%s//g<Left><Left>
    set ignorecase          " Make searching case insensitive
    set smartcase           " ... unless the query has capital letters.
    set magic               " Use 'magic' patterns (extended regular expressions).
    """ Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
    endif
" }

" Formating {
    set showmatch           " Show matching brackets.
    set number              " Show the line numbers on the left side.
    set formatoptions+=o    " Continue comment marker in new lines.
    set textwidth=0         " Hard-wrap long lines as you type them.

    set expandtab           " Insert spaces when TAB is pressed.<Paste>
    set tabstop=4           " Render TABs using this many spaces.
    set shiftwidth=4        " Indentation amount for < and > commands.

    set linespace=0         " GUI: Set line-spacing to minimum.
    set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

    " More natural splits
    set splitbelow          " Horizontal split below current.
    set splitright          " Vertical split to right of current.

    if !&scrolloff
        set scrolloff=3     " Show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
        set sidescrolloff=5 " Show next 5 columns while side-scrolling.
    endif
    set nostartofline       " Do not jump to first character with page commands.

    "" Trailing whitespace, and end-of-lines. VERY useful!
    if &listchars ==# 'eol:$'
        set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    endif
    set list                " Show problematic characters.
" }

" Configuration {
    syntax on
    filetype plugin indent on   " Automatically detect file types.

    set encoding=utf8
    set foldenable          " Auto fold code
    set foldmethod=indent       " Syntax highlighting | using indentation as foldmethod to speed up vim
    set mouse=a                 " Automatically enable mouse usage
    set mousehide 
    "set autochdir           " Switch to current file's parent directory. (Generate Problem in Ack and CtrlP)

    " Remove special characters for filename
    set isfname-=:
    set isfname-==
    set isfname-=+

    "" Remap
    nnoremap ; :    " Use ; for commands.
    nnoremap Q @q   " Use Q to execute default register.

    if &undolevels < 200
        set undolevels=200  " Number of undo levels.
    endif

    " Allow color schemes to do bright colors without forcing bold.
    if &t_Co == 8 && $TERM !~# '^linux'
        set t_Co=16
    endif

    " Remove trailing spaces.
    function! TrimWhitespace()
        let l:save = winsaveview()
        %s/\s\+$//e
        call winrestview(l:save)
    endfunction
    " FIXME: Do not call this on makefile and sv files.
    " autocmd BufWritePre * call TrimWhitespace()
    nnoremap <leader>W :call TrimWhitespace()<CR>

    " Diff options: ignore white spaces
    set diffopt+=iwhite

    " Stop cursor from jumping over wrapped lines
    nnoremap j gj
    nnoremap k gk

    " Make HOME and END behave like shell
    inoremap <C-E> <End>
    inoremap <C-A> <Home>
" }

" UI Options {
    let no_buffers_menu=1   " Enable buffer menu

    " Also highlight all tabs and trailing whitespace characters.
    highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    match ExtraWhitespace /\s\+$\|\t/

    " Relative numbering
    function! NumberToggle()
        if(&relativenumber == 1)
            set nornu
            set number
        else
            set rnu
        endif
    endfunc

    " Toggle between normal and relative numbering.
    nnoremap <leader>r :call NumberToggle()<cr>
" }

" Keybindings {
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qall qall

    "" Close buffer
    noremap <leader>c :bd<CR>

    " Switching windows
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l
    noremap <C-h> <C-w>h
 
    "" Split
    noremap <Leader>h :<C-u>split<CR>
    noremap <Leader>v :<C-u>vsplit<CR>

    " Save file
    nnoremap <Leader>w :w<CR>

    " Copy and paste from system clipboard (Might require xsel/xclip install)
    vmap <Leader>y "+y
    vmap <Leader>d "+d
    nmap <Leader>p "+p
    nmap <Leader>P "+P
    vmap <Leader>p "+p
    vmap <Leader>P "+P

    " Move between buffers
    nmap <Leader>l :bnext<CR>
" }

" PLUGINS
source ~/.config/nvim/plugins/lightline.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/netrw.vim
source ~/.config/nvim/plugins/ctrlp.vim
source ~/.config/nvim/plugins/neomake.vim
source ~/.config/nvim/plugins/ack.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/devicons.vim
source ~/.config/nvim/plugins/tagbar.vim
source ~/.config/nvim/plugins/deoplete.vim
source ~/.config/nvim/plugins/stay.vim
source ~/.config/nvim/plugins/fastfold.vim

" APPEARENCE
source ~/.config/nvim/appearence.vim

" LANGUAGES
source ~/.config/nvim/languages/golang.vim
source ~/.config/nvim/languages/javascript.vim


" vim:set ft=vim sw=4 ts=4:
