set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set encoding=UTF-8          " encoding
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
set colorcolumn=0

filetype plugin indent on   " allows auto-indenting depending on file type

" switch between tabs
map <leader><Tab> :bnext<CR>
map <leader><S-Tab> :bprevious<CR>

" copy and paste from clipboard
map <leader>y "+y
map <leader>v "+p

" pane navigation
map <c-k> :wincmd<Space>k<CR>
map <c-j> :wincmd<Space>j<CR>
map <c-h> :wincmd<Space>h<CR>
map <c-l> :wincmd<Space>l<CR>

" remove colorful boreder pane  
highlight VertSplit ctermbg=NONE 
highlight VertSplit ctermfg=NONE

syntax on                   " syntax highlighting

autocmd VimEnter * set mouse=n " mouse events
autocmd VimEnter * hi CocHintSign ctermfg=Gray
" autocmd VimEnter * hi Normal guibg=None ctermbg=None
" autocmd VimEnter * hi airline_c  ctermbg=NONE guibg=NONE
" autocmd VimEnter * hi airline_tabfill ctermbg=NONE guibg=NONE

" --------------------------------------------------------------
" plugins
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'
Plug 'ap/vim-css-color'
Plug 'bhurlow/vim-parinfer'
Plug 'elkowar/yuck.vim'
Plug 'alvan/vim-closetag'
Plug 'jacoborus/tender.vim'
Plug 'Yggdroot/indentLine'
Plug 'edkolev/tmuxline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'cespare/vim-toml'
Plug 'neoclide/jsonc.vim'
Plug 'psliwka/vim-smoothie'

call plug#end()

let g:indentLine_char = '▏'

let g:airline_powerline_fonts=1
let g:airline_separators=1
let g:airline#extensions#tabline#enabled = 0
" let g:tmuxline_powerline_separators = 0
let g:airline_theme = 'minimalist'

" Enable tender colorscheme 
colorscheme tender

" True color support 

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" -------------------------------------------------------------------
" Rust

let g:rustfmt_command = '/home/helium/.cargo/bin/cargo fmt'
let g:rustfmt_autosave = 1

map <C-s> :!cargo<Space>fmt<CR><CR> 
filetype plugin on

" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Use <c-space> to trigger completion.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ------------------------------------------
"  Nerd Tree
map <F8> :NERDTreeToggle<CR>
highlight VertSplit cterm=NONE

" --------------------------------------------
"  Html
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

" ---------------------------------------------
" Tmuxline
let g:tmuxline_powerline_separators = 1

let g:tmuxline_preset = {
      \'a'    : '#h',
      \'win'  : '#W',
      \'cwin' : '#W',
      \'options': {
        \'status-justify': 'left'}
      \}

" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'b'    : '#W',
"       \'c'    : '#H',
"       \'win'  : '#W',
"       \'cwin' : '#W',
"       \'x'    : '%a',
"       \'y'    : '#W %R',
"       \'z'    : '#H'}


" ---------------------------------------------
