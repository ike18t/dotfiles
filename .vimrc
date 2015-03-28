compiler ruby

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
set showcmd       " display incomplete commands
set history=20

set foldmethod=manual
set foldlevelstart=20

set ignorecase
set smartcase

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
filetype plugin indent on

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'

let g:AckAllFiles = 0
let g:AckCmd = 'ag --type-add ruby=.feature --ignore-dir=tmp --ignore-dir=log 2> /dev/null'

let html_use_css=1
let html_number_lines=0
let html_no_pre=1

let g:ruby_path='/Users/ike/.rbenv/versions/2.2.0'
let g:rubycomplete_buffer_loading = 1

let g:no_html_toolbar = 'yes'

let coffee_no_trailing_space_error = 1
let g:easytags_autorecurse = 1

autocmd FileType ruby runtime ruby_mappings.vim
imap <C-L> <SPACE>=><SPACE>
map <silent> <LocalLeader>cj :!clj %<CR>
"map <silent> <LocalLeader>rt :!ctags -R --exclude=.git --exclude=.svn --exclude=log --exclude=tmp --exclude=db --exclude=pkg --exclude=spec/javascripts/helpers/jasmine-jquery.js --exclude=vendor/bundle/jruby/1.9/gems --extra=+f<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>ff :CtrlP<CR>
map <silent> <LocalLeader>ft :CtrlPTag<CR>
map <silent> <LocalLeader>fb :CtrlPBuffer<CR>
map <silent> <LocalLeader>fr :CtrlPClearAllCache<CR>
map <silent> <LocalLeader>gd :e product_diff.diff<CR>:%!git diff<CR>:setlocal buftype=nowrite<CR>
map <silent> <LocalLeader>pd :e product_diff.diff<CR>:%!svn diff<CR>:setlocal buftype=nowrite<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>yr :YRShow<CR>
map <LocalLeader>aw :Ack '<C-R><C-W>'
map <silent> <LocalLeader>bd :bufdo :bd<CR>
map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>
nnoremap <silent> <LocalLeader><CR> :tabe<CR>
nnoremap <silent> <LocalLeader>[ :tabp<CR>
nnoremap <silent> <LocalLeader>] :tabn<CR>
nnoremap <silent> <LocalLeader><Space> :noh<CR>
nnoremap <silent> <LocalLeader>ww :%s/\s\+$//<CR>:let @/=''<CR><C-o>
inoremap jj <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap <F1> <ESC>

" vimux commands
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <silent> <Leader>rb :wa<CR> :RunAllRubyTests<CR>
map <silent> <Leader>rc :wa<CR> :RunRubyFocusedContext<CR>
map <silent> <Leader>rf :wa<CR> :RunRubyFocusedTest<CR>
map <silent> <Leader>rl :wa<CR> :VimuxRunLastCommand<CR>

cnoremap <Tab> <C-L><C-D>
cnoreabbrev W w

if version >= 700
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
    autocmd FileType tex setlocal spell spelllang=en_us
endif

colorscheme slate

" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

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

" ctrlp settings
nnoremap <silent> <LocalLeader>pp :CtrlP<CR>
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.?(git|hg|svn|vendor|bundle|tmp|public)$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|^tags$|\.keep$',
    \ }
let g:ctrlp_max_files = 0
let g:ctrlp_switch_buffer = 1
let g:ctrlp_max_height = 20
let g:ctrlp_clear_cache_on_exit = 0
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" nerdtree settings
let NERDTreeShowHidden=1

autocmd FocusLost * stopinsert
autocmd VimResized * :wincmd = " auto resize vim when the window is resized

let g:easytags_async = 1

" toggle relative number
function! ToggleRelativeNumber()
  if &relativenumber
    set relativenumber!
  else
    set relativenumber
  endif
endfunction
nnoremap <silent> <LocalLeader>rr :call ToggleRelativeNumber()<cr>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
