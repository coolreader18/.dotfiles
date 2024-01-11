call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'cespare/vim-toml'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'Quramy/tsuquyomi'
Plug 'jason0x43/vim-js-indent'
Plug 'tpope/vim-sleuth'
Plug 'elmcast/elm-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'markdown', 'html'] }
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'farmergreg/vim-lastplace'
Plug 'kelwin/vim-smali'
Plug 'godlygeek/tabular'
Plug 'bfrg/vim-jq'
" Plug 'preservim/vim-markdown'

call plug#end()

let g:rustfmt_autosave = 1
let g:rust_cargo_avoid_whole_workspace = 0

let g:syntastic_mode_map = { "mode": "passive" }

let g:tsuquyomi_javascript_support = 1

let g:elm_syntastic_show_warnings = 1

let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1

command AutoPrettier let g:prettier#autoformat_config_present = 0 | let g:prettier#autoformat = 1
command Prosewrap let g:prettier#config#prose_wrap = 'always'

command Sc SyntasticCheck

set expandtab shiftwidth=2 tabstop=2

set tabpagemax=100

set spelllang=en
au FileType markdown setlocal tw=79 spell

command ClipCopy :%yank +

highlight WhitespaceEOL ctermbg=cyan guibg=cyan
match WhitespaceEOL /\s\+\%#\@<!$/

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" from preservim/vim-markdown, edited to do headers like | ---- | instead of |------|
function! s:TableFormat()
    let l:pos = getpos('.')
    normal! {
    " Search instead of `normal! j` because of the table at beginning of file edge case.
    call search('|')
    normal! j
    " Remove everything that is not a pipe, colon or hyphen next to a colon othewise
    " well formated tables would grow because of addition of 2 spaces on the separator
    " line by Tabularize /|.
    let l:flags = (&gdefault ? '' : 'g')
    execute 's/\(:\@<!-:\@!\|[^|:-]\)//e' . l:flags
    execute 's/--/-/e' . l:flags
    Tabularize /|
    " Move colons for alignment to left or right side of the cell.
    execute 's/:\( \+\)|/\1:|/e' . l:flags
    execute 's/|\( \+\):/|:\1/e' . l:flags
    execute 's/|:\?\zs[ -]\+\ze:\?|/\=" ".repeat("-", len(submatch(0))-2)." "/' . l:flags
    call setpos('.', l:pos)
endfunction
command! -buffer TableFormat call s:TableFormat()
