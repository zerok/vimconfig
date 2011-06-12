call pathogen#runtime_append_all_bundles() 

if !has("unix")
    colorscheme default
else
    colorscheme desert
endif

set encoding=UTF8
set formatoptions=l
set linebreak " break long lines automatically if appropriate

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
nmap <C-T> :CommandT<CR>
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

""" If working in the console, use a dark theme
if !has("gui_running")
    if has("unix")
        set term=xterm
    endif
    set background=dark
else
    if has("macunix")
        set guifont=DejaVuSansMono:h14
        set guifont=Monaco:h12
        nmap <D-+> :maca fontSizeUp:<CR>
        nmap <D--> :maca fontSizeDown:<CR>
        set guioptions-=T
    elseif !has("unix")
        set guifont=Courier\ New:h10
    endif
    set background=dark
    let g:solarized_contrast="high"
    colorscheme solarized
    "" I like my guis light and wide
    set cul " also highlight the current line

    "" Go into complete fullscreen mode
    "set fuoptions=maxvert,maxhorz
    "au GUIEnter * set fullscreen

    imap <C-A> <HOME>
    imap <C-E> <END>
    imap <C-S> <Esc>:w<CR>i
    nmap <D-S-LEFT> :tabprevious<CR>
    nmap <D-S-RIGHT> :tabnext<CR>
    nmap <D-1> 1gt
    nmap <D-2> 2gt
    nmap <D-3> 3gt
    nmap <D-4> 4gt
    nmap <D-5> 5gt
endif

set backspace=indent,eol,start

"" ignore these files always
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store

set swapfile! "" Don't produce swap files
let use_xhtml = "1"

"" Highlight matching braces
set showmatch

"" Some mapping for MRU
map <C-M> :MRU<CR>

set incsearch
"" Expand tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
"" Some indent modes. I really have to find the time to clean them up
set ai
set si
set textwidth=78
set display=lastline "avoid some ugly wrapping at the file-end when scrolling
filetype indent on  "indent depends on filetype
filetype plugin on

"" Set some custom filetypes
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
autocmd BufNewFile,BufRead *.mako set syntax=html
autocmd BufNewFile,BufRead *.rst set syntax=rest
autocmd BufNewFile,BufRead *.mxml set filetype=mxml
autocmd BufNewFile,BufRead *.as set filetype=actionscript
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

function! ToggleBackground()
    if (g:solarized_style=="dark")
    let g:solarized_style="light"
    colorscheme solarized
else
    let g:solarized_style="dark"
    colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()
nnoremap <F5> :call ToggleBackground()<CR>
inoremap <F5> <ESC>:call ToggleBackground()<CR>a
vnoremap <F5> <ESC>:call ToggleBackground()<CR>
nnoremap <F6> :GundoToggle<CR>
inoremap <F6> <ESC>:GundoToggle<CR>a
vnoremap <F6> <ESC>:GundoToggle<CR>

