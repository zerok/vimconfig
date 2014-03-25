execute pathogen#infect()

set encoding=UTF8
set formatoptions=l
set linebreak " break long lines automatically if appropriate

" No line wrapping
set nowrap

" Tabbing with 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=0

"" Line numbering
set nu
set numberwidth=5

set cursorline " highlight the current number

"" Status line stuffed with tons of info
set ruler
set laststatus=2
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [TYPE=%Y\ %{&ff}]\ [%c@%l/%L\ (%p%%)]

"" Some custom key maps
" The j/k mappings make vim move to the next 'visible' line instead of jumping
" to the next 'actual' line. Therefor if vim doesn't automatically break
" lines but instead does some internal wrapping, you can still reach that
" wrapped line with j and k.
nnoremap j gj
nnoremap k gk
nnoremap <C-f> vapgq
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

"" Highlighting
syntax enable

" Highlight the search result and do incremental searching
set showmatch
set hlsearch
set incsearch

set backspace=indent,eol,start

"" ignore these files always
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store

set swapfile! "" Don't produce swap files
let use_xhtml = "1"

" Usable autoindenting
set autoindent
set smartindent

" Leave always at least one line above/below the rollpoint visible
set scrolloff=1

"" Set some custom filetypes
filetype indent on  "indent depends on filetype
filetype plugin on

autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
autocmd BufNewFile,BufRead *.mako set syntax=html
autocmd BufNewFile,BufRead *.rst set syntax=rest
autocmd BufNewFile,BufRead *.mxml set filetype=mxml
autocmd BufNewFile,BufRead *.as set filetype=actionscript
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Jakefile set filetype=javascript
autocmd BufNewFile,BufRead *.gradle set filetype=groovy
autocmd BufNewFile,BufRead *.sublime-settings set filetype=javascript
autocmd BufRead,BufNewFile * set path=$PWD/**

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" http://www.nabble.com/Restore-cursor-position-on-opening-file-td18705333.html
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


" Do some spell checking
set spelllang=de,en
set spellsuggest=5 " I only want the top 5 suggestions

" Key mappings
nnoremap <F6> :GundoToggle<CR>
inoremap <F6> <ESC>:GundoToggle<CR>a
vnoremap <F6> <ESC>:GundoToggle<CR>
map <C-m> :CtrlPMRUFiles<CR>
" Disable highlighting on ctrl+l
nnoremap <silent> <C-l> :nohl<CR><C-l>
map <C-n> :NERDTreeToggle<CR>

" Color Scheme
set background=dark
colorscheme hybrid

" Set the default command for ctrl+p to the MRU listing.
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" Thanks to https://twitter.com/nickstenning/status/441602363410104320
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects
    " .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" https://github.com/asenchi/dotvim/commit/32d561870c72c23dfecdf791f51954b82e73aa9f
if has('autocmd')
    augroup gofmtBuffer
    au!
    autocmd BufWritePre *.go :call GoFormatBuffer()
    augroup END
endif

function! GoFormatBuffer()
    let curr=line(".")
    %!gofmt
    call cursor(curr, 1)
endfunction
set runtimepath+=$GOROOT/misc/vim

" Disable autofolding in riv
let g:riv_fold_auto_update = 0

set omnifunc=syntaxcomplete#Complete

set mouse=a " To enable mouse scrolling etc.

