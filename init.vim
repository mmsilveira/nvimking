"""""""""""""""""""""""""""""""""""""
" msilveira nvim configuration
"""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" Plugins {
    " Utility
    Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeTabsToggle'] }
    Plug 'jistr/vim-nerdtree-tabs', { 'on': ['NERDTreeToggle', 'NERDTreeTabsToggle'] }
    Plug 'majutsushi/tagbar'
    Plug 'jceb/vim-orgmode'
    Plug 'kopischke/vim-stay'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Generic Programming Support
    Plug 'terryma/vim-multiple-cursors'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'sheerun/vim-polyglot'
    Plug 'w0rp/ale'
    Plug 'neomake/neomake'
    Plug 'mattn/emmet-vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'Yggdroot/indentLine'
    Plug 'Konfekt/FastFold'
    Plug 'jiangmiao/auto-pairs'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'janko-m/vim-test'

    " Snippets & Code Completation
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-tern', {'do': 'npm install'}
    Plug 'ncm2/ncm2-go'
    Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
    Plug 'ncm2/ncm2-cssomni'
    Plug 'ncm2/ncm2-html-subscope'
    Plug 'ncm2/ncm2-markdown-subscope'
    Plug 'ncm2/ncm2-rst-subscope'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'

    " Markdown / Writting
    Plug 'reedes/vim-pencil'
    Plug 'tpope/vim-markdown'
    Plug 'jtratner/vim-flavored-markdown'
    Plug 'dpelle/vim-LanguageTool'

    " Git Support
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Theme / Interface
    Plug 'ryanoasis/vim-devicons'
    Plug 'itchyny/lightline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'taohexxx/lightline-buffer'
    Plug 'gorodinskiy/vim-coloresque'
" }
call plug#end()

"""""""""""""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""""""""""""

" Leader
let mapleader=","

 "Config {
    nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
    nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
    nnoremap <leader>q  :help quickref<cr>
 "}

" General {
	syntax on
	filetype plugin indent on " Automatically detect file types.
	set noautoindent          " I indent my code myself.
	set nocindent             " I indent my code myself.
	set foldenable            " Auto fold code
	set foldmethod=indent     " Syntax highlighting | using indentation as foldmethod to speed up vim
	set mouse=a               " Automatically enable mouse usage
	set mousehide             " The mouse pointer is hidden when characters are typed.
	set timeoutlen=1000 ttimeoutlen=0 " Eliminating delays on ESC

	if &undolevels < 200
		set undolevels=200  " Number of undo levels.
	endif
	"set autochdir            " Switch to current file's parent directory.
" }

" Search {
	nnoremap <c-p> :Files<cr>
	nnoremap <c-f> :Ag<space>
	nnoremap <c-s> :%s//g<Left><Left>
	nnoremap <c-c> :noh<cr>
	set ignorecase          " Make searching case insensitive
	set smartcase           " ... unless the query has capital letters.
	set magic               " Use 'magic' patterns (extended regular expressions).
" }

" Formating {
	set showmatch           " Show matching brackets.
	set number              " Show the line numbers on the left side.
	set formatoptions+=o    " Continue comment marker in new lines.
	set textwidth=0         " Hard-wrap long lines as you type them.
	set expandtab           " Insert spaces when TAB is pressed.
	set tabstop=4           " Render TABs using this many spaces.
	set shiftwidth=4        " Indentation amount for < and > commands.
	set linespace=0         " GUI: Set line-spacing to minimum.
	set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
	set splitbelow          " Horizontal split below current.
	set splitright          " Vertical split to right of current.
	set diffopt+=iwhite     " Diff options: ignore white spaces

	if !&scrolloff
		set scrolloff=3     " Show next 3 lines while scrolling.
	endif
	if !&sidescrolloff
		set sidescrolloff=5 " Show next 5 columns while side-scrolling.
	endif
	set nostartofline       " Do not jump to first character with page commands.

	set list                " Show problematic characters.
	if &listchars ==# 'eol:$'
		set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " Trailing whitespace, and end-of-lines. VERY useful!
	endif

	" Remove trailing spaces.
	function! TrimWhitespace()
		let l:save = winsaveview()
		%s/\s\+$//e
		call winrestview(l:save)
	endfunction
	autocmd BufWritePre * call TrimWhitespace()
	nnoremap <leader>W :call TrimWhitespace()<CR>

	" Remove special characters for filename
	set isfname-=:
	set isfname-==
	set isfname-=+
" }

" UI Options {
	let no_buffers_menu=1   " Enable buffer menu

	" Allow color schemes to do bright colors without forcing bold.
	if &t_Co == 8 && $TERM !~# '^linux'
		set t_Co=16
	endif

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

	" Use ; for commands.
	nnoremap ; :

	" Use Q to execute default register.
	nnoremap Q @q

	" Close buffer
	noremap <leader>c :bd<CR>

	" Switching windows
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l
	noremap <C-h> <C-w>h

	" Stop cursor from jumping over wrapped lines
	nnoremap j gj
	nnoremap k gk

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

" Plugins {
	source ~/.config/nvim/plugins/devicons.vim
	source ~/.config/nvim/plugins/fastfold.vim
	source ~/.config/nvim/plugins/fugitive.vim
	source ~/.config/nvim/plugins/languagetool.vim
	source ~/.config/nvim/plugins/lightline.vim
	source ~/.config/nvim/plugins/markdown.vim
	source ~/.config/nvim/plugins/nerdtree.vim
	source ~/.config/nvim/plugins/netrw.vim
	source ~/.config/nvim/plugins/neomake.vim
	source ~/.config/nvim/plugins/ncm2.vim
	source ~/.config/nvim/plugins/pencil.vim
	source ~/.config/nvim/plugins/stay.vim
	source ~/.config/nvim/plugins/tagbar.vim
	source ~/.config/nvim/plugins/ultisnips.vim
" }

" Appearence {
	source ~/.config/nvim/appearence.vim
" }

" Languages {
	source ~/.config/nvim/languages/javascript.vim
	source ~/.config/nvim/languages/golang.vim
" }

" vim:set ft=vim sw=4 ts=4:
