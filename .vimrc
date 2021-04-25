call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'cespare/vim-toml'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'Quramy/tsuquyomi'
Plug 'jason0x43/vim-js-indent'
Plug 'tpope/vim-sleuth'
Plug 'elmcast/elm-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'markdown'] }
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'farmergreg/vim-lastplace'

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

set expandtab shiftwidth=2

set spelllang=en
au FileType markdown setlocal tw=79 spell

command ClipCopy :%yank +
