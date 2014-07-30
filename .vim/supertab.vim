" Remap autocomplete menu control keys
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> j pumvisible() ? "\<C-n>" : "j"
inoremap <expr> k pumvisible() ? "\<C-p>" : "k"
inoremap <expr> h pumvisible() ? "\<PageUp>\<C-n>\<C-p>" : "h"
inoremap <expr> l pumvisible() ? "\<PageDown>\<C-n>\<C-p>" : "l"
"
let g:SuperTabCrMapping = 0 " prevent remap from breaking supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
set wildmode=list:longest,full
let g:SuperTabClosePreviewOnPopupClose = 1 " close scratch window on
autocompletion
