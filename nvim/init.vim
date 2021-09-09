" Use vundle as a package manager
" After adding a plugin to this list, restart
" vim and run :PluginInstall

set nocompatible
filetype off   
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Make FocusGained and FocusLost hooks work
Plugin 'sjl/vitality.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'andymass/vim-matchup'
Plugin 'kana/vim-textobj-user'
Plugin 'neomake/neomake'
Plugin 'janko/vim-test'
Plugin 'benmills/vimux'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'ap/vim-buftabline'
Plugin 'w0rp/ale' " for running flake8
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()

filetype plugin indent on 
set laststatus=2

set guicursor=n-v-c:hor99,i-ci-ve:ver25,r-cr:hor20,o:hor99



" modest tabstops using spaces
set tabstop=2 shiftwidth=2 expandtab

au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

set encoding=utf-8

let g:markdown_fenced_languages = ['python']

syntax enable

highlight clear
set termguicolors
highlight Normal gui=None guifg='#AD9D8B' guibg=None
highlight Constant gui=None guifg='#449dac'
highlight markdownLinkText gui=None guifg='#449dac'
highlight markdownUrl gui=None guifg='#777777'
highlight htmlLink gui=None guifg='#449dac'
highlight htmlAttribute gui=italic guifg='#449dac'
highlight Identifier gui=None guifg='#b38c00'
highlight SpellBad gui=reverse guifg=None
highlight Statement gui=None guifg='#7e9c1d'
highlight Type gui=None guifg='#34a37e'
highlight markdownCode gui=None guifg='#34a37e'
highlight Special gui=None guifg='#34a37e'
highlight Keyword gui=None guifg='#e17141'
highlight Bold gui=None guifg='#e16b80'
highlight Comment gui=None guifg='#777777'
highlight NonText gui=None guifg='#777777'
highlight vimHiAttrib gui=None guifg='#e17141'
highlight vimOption gui=None guifg='#e17141'
highlight htmlH1 gui=None guifg='#e16b80'
highlight htmlH2 gui=None guifg='#e16b80'
highlight htmlH3 gui=None guifg='#e16b80'
highlight htmlH4 gui=None guifg='#e16b80'
highlight htmlH5 gui=None guifg='#e16b80'
highlight markdownH1 gui=None guifg='#e16b80'
highlight markdownH2 gui=None guifg='#e16b80'
highlight markdownH3 gui=None guifg='#e16b80'
highlight markdownH4 gui=None guifg='#e16b80'
highlight markdownH5 gui=None guifg='#e16b80'
highlight markdownItalic gui=italic
highlight markdownBold gui=bold 
highlight markdownCodeDelimiter guifg='#e16b80'
highlight markdownHeadingDelimiter guifg='#e16b80'
highlight VertSplit gui=None guifg=8
highlight StatusLine gui=underline,italic guifg='#777777' guibg=None
highlight StatusLineNC gui=underline,italic guifg='#777777' guibg=None
highlight LineNr guifg='#777777' guibg=None gui=italic
highlight LineNrAbove guifg='#777777' guibg=None
highlight LineNrBelow guifg='#777777' guibg=None
highlight CursorLineNr gui=None guifg='#777777' guibg='#093b44'
highlight FoldColumn guifg='#929285' guibg=None
highlight SignColumn guifg='#929285' guibg=None
highlight Folded guifg='#929285'  guibg=None
highlight Search gui=reverse guifg=None guibg=None
highlight DiffAdd guibg='#38380b'
highlight DiffChange guibg='#292d42'
highlight DiffText guibg='#1e00c7'
highlight DiffDelete guibg='#5c1111'
highlight Pmenu gui=bold guibg='#929285' guifg='#2e2e2a'
highlight PmenuSel gui=bold guibg='#093b44' guifg='#929285'
highlight SignColumn guibg='#5c1111'

highlight mkdStrike guifg='#555555'

highlight BufTabLineCurrent gui=underline,italic,bold guifg='#777777' guibg='#093b44'
highlight BufTabLineActive gui=underline,italic,bold guifg='#777777' guibg=None
highlight BufTabLineHidden gui=underline,italic guifg='#777777' guibg=None
highlight BufTabLineFill gui=underline guifg='#777777' guibg=None
highlight NetrwPlain guifg='#EDDDCB'

syntax keyword myTodo "to"
highlight link myTodo Constant


set cul
autocmd FocusGained,WinEnter,BufEnter,BufWinEnter * set cul
autocmd FocusLost,WinLeave,BufLeave,BufWinLeave * set nocul

highlight CursorLine gui=none guibg='#093b44'
highlight Visual gui=none guibg='#1e00c7'
highlight MatchParen gui=none guibg='#1e00c7'

set statusline=..\ %F\ ..
set statusline+=%=
set statusline+=..\ %l/%L\ ..


let mapleader="s"

if has('nvim')
  nmap <BS> <C-W>h
endif


:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" keybindings for lilypond files
augroup lilypond_settings " {
  autocmd!
  autocmd BufNewFile,BufRead *.ly nnoremap <silent> <Leader>ll :w<Return>:se makeprg=lilypond\ %<<Return>:make<Return>
  autocmd BufNewFile,BufRead *.ly nnoremap <silent> <Leader>lm :w<Return>:se makeprg=lilypond\ %<<Return>:make<Return>:!timidity %<.midi <Return>
augroup END " }

" NerdTree config
nnoremap <Leader>n :NERDTreeFocus<Return> " Use the Focus version so it doesn't close open directories

" all-purpose PDF opener
nnoremap <Leader>o :!open -a Skim %<.pdf<Return>

" vim-test config
let test#python#runner = 'pytest'
let test#strategy = "vimux"

nnoremap <Leader>tn :TestNearest<CR> 
nnoremap <Leader>tf :TestFile<CR>    
nnoremap <Leader>ts :TestSuite<CR>   
nnoremap <Leader>tl :TestLast<CR>    
nnoremap <Leader>tg :TestVisit<CR>   
"
" allow dirty buffers to be hidden and allow easy navigation
set hidden
nnoremap <SPACE> <Nop>
let maplocalleader=" "
let g:buftabline_indicators=1
let g:buftabline_numbers=2
autocmd FileType netrw setl bufhidden=wipe
nnoremap <localleader>= :bnext<CR>
nnoremap <localleader>- :bprev<CR>
nmap <localleader>h :Ranger<CR>
nmap <localleader>1 <Plug>BufTabLine.Go(1)
nmap <localleader>2 <Plug>BufTabLine.Go(2)
nmap <localleader>3 <Plug>BufTabLine.Go(3)
nmap <localleader>4 <Plug>BufTabLine.Go(4) 
nmap <localleader>5 <Plug>BufTabLine.Go(5)
nmap <localleader>6 <Plug>BufTabLine.Go(6)
nmap <localleader>7 <Plug>BufTabLine.Go(7)
nmap <localleader>8 <Plug>BufTabLine.Go(8)
nmap <localleader>9 <Plug>BufTabLine.Go(9)

function! WinNrFromFakeBufNr(n)
  return bufwinnr(get(buftabline#user_buffers(),a:n-1))
endfunction

nnoremap <localleader>j1 :exe WinNrFromFakeBufNr(1) . 'wincmd w'<CR>
nnoremap <localleader>j2 :exe WinNrFromFakeBufNr(2) . 'wincmd w'<CR>
nnoremap <localleader>j3 :exe WinNrFromFakeBufNr(3) . 'wincmd w'<CR>
nnoremap <localleader>j4 :exe WinNrFromFakeBufNr(4) . 'wincmd w'<CR>
nnoremap <localleader>j5 :exe WinNrFromFakeBufNr(5) . 'wincmd w'<CR>
nnoremap <localleader>j6 :exe WinNrFromFakeBufNr(6) . 'wincmd w'<CR>
nnoremap <localleader>j7 :exe WinNrFromFakeBufNr(7) . 'wincmd w'<CR>
nnoremap <localleader>j8 :exe WinNrFromFakeBufNr(8) . 'wincmd w'<CR>
nnoremap <localleader>j9 :exe WinNrFromFakeBufNr(9) . 'wincmd w'<CR>

function! SwapBuftablineNumbers()
  if g:buftabline_numbers ==? 2
    let g:buftabline_numbers=1
    highlight BufTabLineCurrent guifg='#34a47e'
    highlight BufTabLineActive guifg='#34a47e'
    highlight BufTabLineHidden guifg='#34a47e'
    highlight BufTabLineFill guifg='#34a47e' 
  else
    let g:buftabline_numbers=2
    highlight BufTabLineCurrent guifg='#777777'
    highlight BufTabLineActive guifg='#777777'
    highlight BufTabLineHidden guifg='#777777'
    highlight BufTabLineFill guifg='#777777' 
  endif
  :call buftabline#update(0)
endfunction

nnoremap <localleader>n :call SwapBuftablineNumbers()<CR>


augroup netrw_mapping
  autocmd!
  autocmd FileType netrw highlight CursorLine gui=none guibg='#093b44'
augroup END


" Ctrl-hjkl to move between windows
tnoremap <Esc> <C-\><C-n>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

" Always enter terminal buffers in terminal insert mode
augroup nhooyr_terminal
  autocmd!
  autocmd BufEnter term://* startinsert
augroup END

" Hide markdown around bolded/italicized text, just show the bold/italic
set conceallevel=2
let g:vim_markdown_strikethrough=1

let g:surround_109 = "{% \1tag: \1 %}\r{% /\1\1 %}"




