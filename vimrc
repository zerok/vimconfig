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
" Disable highlighting on ctrl+l
nnoremap <silent> <C-l> :nohl<CR><C-l>
map <C-n> :NERDTreeToggle<CR>

" Color Scheme
set background=dark
colorscheme hybrid

" Set the default command for ctrl+p to the MRU listing.
" let g:ctrlp_cmd = 'CtrlPMRU'
set runtimepath^=~/.vim/bundle/ctrlp.vim

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

" Disable autofolding in riv
let g:riv_fold_auto_update = 0

