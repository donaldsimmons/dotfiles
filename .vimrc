
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

let mapleader=","

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"   ======  Vundle Config =====
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle "gmarik/vundle"

" My Bundles Here
Bundle 'rking/ag.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'slim-template/vim-slim'

"   ====== End Vundle Config =====


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Centralize backups, swapfiles, and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set noerrorbells " disable error bells
set visualbell " enable visual bells
set number

set wrap
set linebreak
set showbreak=>\ \ \

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax enable
  set background=dark
	let g:solarized_termcolors=256
	colorscheme solarized
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Indentation Settings
filetype indent on
set ts=2 sw=2 expandtab autoindent

" Open Files
noremap <leader>vrc :tabnew ~/.vimrc<cr>
noremap <leader>zrc :tabnew ~/.zshrc<cr>

" Source Files
noremap <leader>sv :source ~/.vimrc<cr>

" Save Files
noremap <leader>s :w<cr>:echom "File Saved"<cr>

" Insert Binding.pry
noremap <leader>bp <insert>binding.pry<esc>

" Comment Lines
noremap <leader>/ '<,'>I/<esc>

" Open Tab
inoremap <c-t> <esc>:tabnew
nnoremap <c-t> :tabnew
vnoremap <c-t> <esc>:tabnew

" Move Between Tabs
inoremap <c-n> <esc>:tabn<cr>
nnoremap <c-n> :tabn<cr>
vnoremap <c-n> <esc>:tabn<cr>
inoremap <c-p> <esc>:tabp<cr>
nnoremap <c-p> :tabp<cr>
vnoremap <c-p> <esc>:tabp<cr>

inoremap <leader><leader> <c-^>
vnoremap <leader><leader> <c-^>
nnoremap <leader><leader> <c-^>

" Show terminal
noremap <leader>! :!<cr>

" Auto-Close Bindings
inoremap (<space> ()<left>
inoremap {<space> {  }<left><left>
inoremap [<space> []<left>
inoremap '<space> ''<left>
inoremap "<space> ""<left>

" =========== TODO ===> Create Plugin to handle these mappings and selections 
" Wrap Word in Quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel"
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel

" Trailing Whitespace
noremap <leader>ws ma:%s/\s\+$//g<cr>`a:delmarks a<cr>

map <leader>z :call InsertBindingPry()<cr>

function! InsertBindingPry()
  if &ft == "javascript"
    echom "Javascript"
  elseif &ft == "html"
    echom "HTML"
  else
    echom "Neither"
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!zeus cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!zeus rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!zeus rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

map <leader>rt :call RunCurrentTest()<CR>
map <leader>rl :call RunCurrentLineInTest()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End bjo stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrl-P Settings
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<leader>f'
let g:ctrlp_custom_ignore = 'tmp\|log\|public\|vendor/assets\|vendor/bundle\|vendor/plugins\|spec/cassett\|\.git\|cassett\|/.git\|/app/assets/image\|/coverage'
let g:ctrlp_working_path_mode = 0
nnoremap <leader>b :CtrlPBuffer<cr>

" grep under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Jump Between Spec and Code
map <leader>j :call JumpBetweenSpecAndCode()<CR>

function! JumpBetweenSpecAndCode()
  let filename = expand("%:t")
  if filename =~ '_spec\.'
  let filename = substitute(filename, '_spec', '', '')
  let foundfile = findfile(filename, ";,**")
  exec "edit " . foundfile
  else
  let filename = substitute(filename, '\.', '_spec\.', '')
  let foundfile = findfile(filename, ";,**")
  exec "edit " . foundfile
  endif
endfunction

"""""""The Silver Searcher
if executable('ag')
  "Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  "Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  "ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>
