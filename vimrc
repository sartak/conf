" vim:foldmethod=marker commentstring="%s

" I configure vim with:
"   ./configure
"               --without-x
"               --disable-gui
"               --disable-xim
"               --disable-darwin
"               --enable-perlinterp
"               --enable-rubyinterp
"               --enable-multibyte

" General options {{{
" Miscellaneous {{{
" stop using vi defaults, this is 2011
set nocompatible

" filetype-specific functionality
" see also http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype indent plugin on

" automatically flush to disk when using :make, etc.
set autowrite

" automatically read in external changes if we haven't yet modified the buffer
set autoread

" everything needs to be unicode. EVERYTHING
set termencoding=utf-8
set encoding=utf-8

" always join with just one space, even between sentences
set nojoinspaces

" don't move the cursor to the start of the line when changing buffers
set nostartofline
"}}}
" Display {{{
" lines, cols in status line
set ruler

" display more information in the ruler
set rulerformat=%40(%=%t%h%m%r%w%<\ (%n)\ %4.7l,%-7.(%c%V%)\ %P%)

" current mode in status line
set showmode

" display the number of (characters|lines) in visual mode, also current command
set showcmd

" a - terse messages (like [+] instead of [Modified])
" o - don't show both reading and writing messages if both occur at once
" t - truncate file names
" T - truncate messages rather than prompting to press enter
" W - don't show [w] when writing
" I - no intro message when starting vim fileless
set shortmess=aotTWI

" no extra status lines
set laststatus=0

" display as much of the last line as possible if it's really long
" also display unprintable characters as hex
set display+=lastline,uhex

" give three lines of context when moving the cursor around
set scrolloff=3

" don't redraw the screen during macros etc (NetHack's runmode:teleport)
set lazyredraw

" highlight search matches
set hlsearch

" highlight matching parens for .1s
set showmatch
set matchtime=1

" threshold for reporting number of lines changed in an s/// etc
set report=0

" I generally don't want to have to space through things.. :)
set nomore

" only show a menu for completion, never a preview window or things like that
set completeopt=menuone

" hide the mouse in the gui while typing
set mousehide
" Language specific display {{{
" Perl {{{
" highlight advanced perl vars inside strings
let perl_extended_vars=1

" POD!
let perl_include_pod=1

" perl needs lots of syncing...
let perl_sync_dist=1000

" Improve qw() and friends
let perl_string_as_statement=1
" }}}
" }}}
" Colors {{{
" syntax highlighting {{{
syntax on
" }}}
" default colorscheme {{{
" I hate the bright colors that go with bg=dark, even though my bg is black
set bg=light
" }}}
" word completion menu {{{
highlight Pmenu      ctermfg=grey  ctermbg=darkblue
highlight PmenuSel   ctermfg=red   ctermbg=darkblue
highlight PmenuSbar  ctermbg=cyan
highlight PmenuThumb ctermfg=red

highlight WildMenu ctermfg=grey ctermbg=darkblue
"}}}
" folding {{{
highlight Folded     ctermbg=black ctermfg=darkgreen
"}}}
" hlsearch {{{
highlight Search NONE ctermfg=lightred
"}}}
" color end of line whitespace unobnoxiously {{{
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
" }}}
" conflict markers {{{
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}
"}}}
"}}}
" Improve power of commands {{{
" incremental search!
set incsearch

" make tilde (flip case) an operator instead of always operating on the next char
set tildeop

" backspace over autoindent, end of line (to join lines), and preexisting test
set backspace=indent,eol,start

" tab completion in ex mode
set wildmenu

" when doing tab completion, ignore files with any of the following extensions
set wildignore+=.log,.out,.o

" remember lotsa fun stuff
set viminfo=!,'1000,f1,/1000,:1000,<1000,@1000,h,n~/.viminfo

" add : as a file-name character (mostly for Perl's mod::ules)
set isfname+=:

" tab completion stuff for the command line
set wildmode=longest,list,full

" always make the help window cover the entire screen
set helpheight=9999

" for s///, make /g the default (use s///gg to disable)
set gdefault

" persistent undo
if exists("+undofile")
    set undofile
    set undodir=~/tmp/undo
endif

" lowercase search strings are case insensitive
set ignorecase
set smartcase

" better gq
set formatprg=fmt
"}}}
" Make vim less whiny {{{
" :bn with a change in the current buffer? no prob!
set hidden

" no bells whatsoever
set vb t_vb=

" if you :q with changes it asks you if you want to continue or not
set confirm

" or better yet, just :w for me
set autowriteall

" 50 milliseconds for escape timeout instead of 1000
set ttimeoutlen=50

" send more data to the terminal in a way that makes the screen update faster
set ttyfast

" swapfiles have been nothing but a nuisance to me
set noswapfile
"}}}
" Indentation {{{
" no-longer skinny tabs!
set tabstop=4

" set to the same as tabstop (see #4 in :help tabstop)
set shiftwidth=4

" if it looks like a tab, we can delete it like a tab
set softtabstop=4

" no tabs! spaces only..
set expandtab

" < and > will hit indentation levels instead of always -4/+4
set shiftround

" new line has indentation equal to previous line
set autoindent

" braces affect autoindentation
set smartindent
"}}}
" Folding {{{
" fold only when I ask for it damnit!
set foldmethod=marker

" close a fold when I leave it
set foldclose=all
"}}}
"}}}
" Autocommands {{{
" When editing a file, always jump to the last cursor position {{{
autocmd BufReadPost *
\  if line("'\"") > 0 && line("'\"") <= line("$") |
\    exe "normal g`\"" |
\  endif
"}}}
" Perl :make does a syntax check {{{
autocmd FileType perl setlocal makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $*
autocmd FileType perl setlocal errorformat=%f:%l:%m
autocmd FileType perl setlocal keywordprg=perldoc\ -f
"}}}
" Syntax highlighting hints {{{
autocmd BufRead,BufNewFile share/html/* set syn=mason
autocmd BufRead,BufNewFile *.md set syn=markdown
autocmd BufRead,BufNewFile *.psgi set syn=perl
" }}}
" Source vimrc after editing {{{
autocmd BufWritePost .vimrc source ~/.vimrc
autocmd BufWritePost  vimrc source ~/.vimrc
" }}}
" when I wander away, save (I use version control, no big deal) {{{
autocmd FocusLost * :wa
" }}}
"}}}
" Insert-mode remappings/abbreviations {{{
" Hit <C-a> in insert mode after a bad paste (thanks absolon) {{{
inoremap <silent> <C-a> <ESC>u:set paste<CR>.:set nopaste<CR>gi
"}}}
" Words I misspell.. (don't laugh) {{{
iabbrev lamdba lambda
iabbrev dvice device
iabbrev emdash mdash
iabbrev endash ndash
iabbrev priviledge privilege
"}}}
" I need proper snippets {{{
iabbrev bdeparse use B::Deparse; warn B::Deparse->new("-p", "-sC")->coderef2text();
iabbrev lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras a ornare metus. In justo metus, auctor nec semper in, laoreet porttitor augue. Maecenas tortor libero, dignissim vel placerat sit amet, malesuada ut quam. Curabitur vitae velit lacus, sed imperdiet sapien. Sed posuere, odio nec pharetra adipiscing
" }}}
" }}}
" Normal-mode remappings {{{
" spacebar (in command mode) inserts a single character before the cursor
nmap <Space> i <Esc>r

" have Y behave analogously to D rather than to dd
nmap Y y$

" make help easier to navigate
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>

" right and left switch buffers
nmap <Right> :bn<CR>
nmap <Left>  :bp<CR>

" visualize and navigate the undo information superhighway
nmap gu :silent GundoToggle<CR>

" up and down move by virtual line
nmap <Up>   gk
nmap <Down> gj

" keep visual selection on in/out-dent
xnoremap < <gv
xnoremap > >gv

" now search commands will re-center the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Swap ` (preserves which column the cursor was in) and ' (which does not)
nnoremap ' `
nnoremap ` '

" leader commands {{{
" \/ turn off highlighting after a search
nmap <silent> <leader>/ :nohl<CR>

" \s syntax coloring
nmap <silent> <leader>ss :syntax sync fromstart<CR>
nmap <silent> <leader>sm :setf mason<CR>\ss
nmap <silent> <leader>sh :setf html<CR>\ss
nmap <silent> <leader>sp :setf perl<CR>\ss
nmap <silent> <leader>sj :setf javascript<CR>\ss
nmap <silent> <leader>s2 :setf tt2html<CR>\ss
nmap <silent> <leader>st :setf text<CR>:set tw=72<CR>:set spell spelllang=en_us<CR>

" Nopaste \p {{{
function! s:nopaste(visual)
    let nopaste_services = $NOPASTE_SERVICES
    if &filetype == 'tex'
        let $NOPASTE_SERVICES = "Mathbin ".$NOPASTE_SERVICES
    endif

    if a:visual
        silent exe "normal gv!nopaste -x\<CR>"
    else
        let pos = getpos('.')
        silent exe "normal gg!Gnopaste -x\<CR>"
    endif
    silent undo
    if a:visual
        normal gv
    else
        call setpos('.', pos)
    endif
    let $NOPASTE_SERVICES = nopaste_services
endfunction
nmap <silent> <Leader>p :call <SID>nopaste(0)<CR>
xmap <silent> <Leader>p :<C-U>call <SID>nopaste(1)<CR>
" }}}
" AlignAssignments \= {{{
function! AlignAssignments ()
    " Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?[=:]\@<![=:][=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'

    " Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    " Decompose lines at assignment operators...
    let lines = []
    for linetext in getline(firstline, lastline)
        let fields = matchlist(linetext, ASSIGN_LINE)
        call add(lines, fields[1:3])
    endfor

    " Determine maximal lengths of lvalue and operator...
    let op_lines = filter(copy(lines),'!empty(v:val)')
    let max_lval = max( map(copy(op_lines), 'strlen(v:val[0])') ) + 1
    let max_op   = max( map(copy(op_lines), 'strlen(v:val[1])'  ) )

    " Recompose lines with operators at the maximum length...
    let linenum = firstline
    for line in lines
        if !empty(line)
            let newline
            \    = printf("%-*s%*s%s", max_lval, line[0], max_op, line[1], line[2])
            call setline(linenum, newline)
        endif
        let linenum += 1
    endfor
endfunction

nmap <silent> <leader>= :call AlignAssignments()<CR>
" }}}
" StripTrailingWhitespace \<space> {{{
function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>
" }}}
" }}}
" }}}
" Command-mode remappings (: and /) {{{
" Make ^A and ^E work like in a shell
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" }}}
" Plugin settings {{{
" Supertab {{{
let g:SuperTabMidWordCompletion = 0
let g:SuperTabDefaultCompletionType = 'context'
" }}}
" YankRing {{{
let g:yankring_history_dir = '~/.vim/'

" 'nmap Y y$' doesn't actually work with yankring
function! YRRunAfterMaps()
    nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
endfunction
" }}}
" command-t {{{
let g:CommandTMinHeight = 3
let g:CommandTMaxHeight = 3
nmap <silent> <C-T> :CommandT<CR>
nmap <silent> t :CommandT<CR>
" }}}
" easymotion {{{
let g:EasyMotion_leader_key = '_'
" }}}
" }}}
