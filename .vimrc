set hlsearch
set number
set showmatch
set incsearch
set background=dark
set noshowmode
set hidden
set backspace=indent,eol,start
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set ruler
set wrap
set dir=/tmp//
set scrolloff=5
set autowrite
set nobackup
set nowritebackup
set noswapfile
set showcmd " display incomplete commands
set history=20
set wildmenu " visual autocomplete for command menu
set foldenable foldmethod=manual foldlevelstart=20

set ignorecase
set smartcase

set lazyredraw " redraw only when we need to.

if has('nvim')
  " live %s preview
  set inccommand=split
endif

syntax on

let path = expand('<sfile>:p:h')

if filereadable(expand(path . '/.vimrc.bundles'))
  exec 'source' . expand(path . '/.vimrc.bundles')
endif

if filereadable(expand(path . '/.vimrc.lsp'))
  exec 'source' . expand(path . '/.vimrc.lsp')
endif

if filereadable(expand(path . '/.vimrc.treesitter'))
  exec 'source' . expand(path . '/.vimrc.treesitter')
endif

if filereadable(expand(path . '/.vimrc.ale'))
  exec 'source' . expand(path . '/.vimrc.ale')
endif

if filereadable(expand(path . '/.vimrc.telescope'))
  exec 'source' . expand(path . '/.vimrc.telescope')
endif


filetype plugin on

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'

let html_use_css=1
let html_number_lines=0
let html_no_pre=1

imap <C-L> <SPACE>=><SPACE>

map <silent> <LocalLeader>cj :!clj %<CR>

let NERDTreeShowHidden=1
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
set termguicolors

map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>bd :bufdo :bd<CR>
map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>
nnoremap <silent> <LocalLeader><CR> :tabe<CR>
nnoremap <silent> <LocalLeader>[ :tabp<CR>
nnoremap <silent> <LocalLeader>] :tabn<CR>
nnoremap <silent> <LocalLeader><Space> :noh<CR>
nnoremap <silent> <LocalLeader>ws :%s/\s\+$//<CR>:let @/=''<CR><C-o>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap <F1> <ESC>
" move vertically by visual line
nnoremap j gj
nnoremap k gk

let test#javascript#jasmine#executable = 'npm test'
let test#javascript#jasmine#file_pattern = '\v^spec/.*spec(\.js)?\.(ts|js|jsx|coffee)$'

set completeopt=menuone,noselect

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

set omnifunc=syntaxcomplete#Complete
inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-K>"

" Find files using Telescope command-line sugar.
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>ff :lua require('telescope.builtin').find_files({ find_command = { 'rg', '--smart-case', '--files', '--hidden', '--follow' } })<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

if executable('tmux')
  let test#strategy = "vimux"
endif

" vimux commands
map <Leader>vt :VimuxTogglePane<CR>
map <Leader>vz :VimuxZoomRunner<CR>

map <silent> <Leader>rb :wa<CR> :TestFile<CR>
map <silent> <Leader>rc :wa<CR> :TestSuite<CR>
map <silent> <Leader>rf :wa<CR> :TestNearest<CR>
map <silent> <Leader>rl :wa<CR> :TestLast<CR>

map <silent> <Leader>jq :%!jq '.'<CR>

cnoremap <Tab> <C-L><C-D>
cnoreabbrev W w

autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
autocmd FileType tex setlocal spell spelllang=en_us

colorscheme atom-dark-256

" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

" Comment colors
highlight Comment ctermfg=DarkMagenta
highlight clear SignColumn
highlight SignifySignAdd    cterm=bold ctermfg=119
highlight SignifySignDelete cterm=bold ctermfg=167
highlight SignifySignChange cterm=bold ctermfg=227

set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

set undodir=~/.vim/undo
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set hlsearch
highlight Search ctermbg=black ctermfg=lightgray

nnoremap ; :
vnoremap ; :

autocmd FocusLost * stopinsert
autocmd VimResized * :wincmd = " auto resize vim when the window is resized

function! ToggleRelativeNumber()
  if &relativenumber
    set relativenumber!
  else
    set relativenumber
  endif
endfunction
nnoremap <silent> <LocalLeader>rr :call ToggleRelativeNumber()<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE

autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca <cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>

lua <<EOF
  require 'colorizer'.setup()

  require('lspkind').init({
      with_text = false
  })
EOF

" nvim-lua/completion-nvim
autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
