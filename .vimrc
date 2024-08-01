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
if filereadable(expand(path . '/.vimrc.coc'))
  exec 'source' . expand(path . '/.vimrc.coc')
endif

filetype indent plugin on

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'

let html_use_css=1
let html_number_lines=0
let html_no_pre=1

" let g:no_html_toolbar = 'yes'
let NERDTreeShowHidden=1

imap <C-L> <SPACE>=><SPACE>
map <silent> <LocalLeader>cj :!clj %<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
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

map <silent> <LocalLeader>ff :Files<CR>
map <silent> <LocalLeader>fg :GFiles<CR>
map <silent> <LocalLeader>fG :GFiles?<CR>
map <silent> <LocalLeader>fb :Buffers<CR>
map <silent> <LocalLeader>fc :Commits<CR>ap <silent> <LocalLeader>ff :CtrlP<CR>

if executable('tmux')
  let test#strategy = "vimux"
endif

set completeopt=longest,menuone,preview

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

set termguicolors
let $FZF_DEFAULT_COMMAND = 'ag -g "" -p "$(git rev-parse --is-inside-work-tree &>/dev/null && echo "$(git rev-parse --show-toplevel)/.gitignore")" "$@"'

nnoremap <leader>ag :Grepper -tool ag -cword -noprompt<cr>
runtime plugin/grepper.vim
let g:grepper.ag.grepprg .= ' -p "$(git rev-parse --is-inside-work-tree &>/dev/null && echo "$(git rev-parse --show-toplevel)/.gitignore")" --smart-case'
cnoreabbrev Ag GrepperAg

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

set cmdheight=1

if exists('$TMUX')
  autocmd BufEnter,FocusGained * call system("tmux rename-window " . system("pwd | xargs basename"))
  autocmd VimLeave * call system("tmux rename-window zsh")
endif
