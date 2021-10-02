" Copyright 2021 Dimitrios-Georgios Akestoridis
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are
" met:
"
" 1. Redistributions of source code must retain the above copyright
" notice, this list of conditions and the following disclaimer.
"
" 2. Redistributions in binary form must reproduce the above copyright
" notice, this list of conditions and the following disclaimer in the
" documentation and/or other materials provided with the distribution.
"
" 3. Neither the name of the copyright holder nor the names of its
" contributors may be used to endorse or promote products derived from
" this software without specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
" "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
" LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
" A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
" HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
" SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
" LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
" DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
" THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
" OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

" Load a color scheme and enable syntax highlighting
colorscheme badwolf
syntax enable

" Set the font that will be used for the GUI version of Vim
set guifont=Monospace\ Regular\ 11

" Display invisible characters
set listchars=eol:¬,tab:¦»,space:·,trail:·,extends:>,precedes:<,nbsp:~
set list

" Define the default indentation configuration
set tabstop=8
set softtabstop=0
set shiftwidth=8
set noexpandtab

" Enable filetype-specific indentation configuration
filetype indent on

" Display text metadata
set number
set numberwidth=5
set colorcolumn=71,79
set laststatus=2

" Join commands should insert only one space character
set nojoinspaces

" Modify the statusline
set statusline=#%n:\ %1*%{ModeText(1)}
set statusline+=%2*%{ModeText(2)}
set statusline+=%3*%{ModeText(3)}
set statusline+=%4*%{ModeText(4)}
set statusline+=%5*%{ModeText(5)}
set statusline+=%*%<\ %f\ %w%{BufferBytes()}
set statusline+=%5*%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%5*%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%5*%r%m
set statusline+=%*\ \ %=%Y\ \ %6(0x%B%)\ \ %7(%c%V%)\ \ %9(%l/%L%)\ \ %P%*

" Enable text wrapping
set wrap
set linebreak
set showbreak=>>>>>
set cpoptions+=n

" Enable text highlighting
set nocursorline
set showmatch

" Define the number of context lines above and below the cursor
set scrolloff=5

" Define the default search configuration
set incsearch
set hlsearch

" Display commands
set showcmd
set wildmenu

" Enable spell checking
set t_Cs=
set spell spelllang=en
set complete+=kspell

" Enable the use of the mouse
set mouse=a

" When the window is split vertically, put the new window to the right
set splitright

" Fold lines with the same level of indentation
set foldmethod=indent
set foldlevelstart=99

" Use the system clipboard for copy and paste
set clipboard=unnamedplus

" Show current index and total count when searching
set shortmess-=S

" Enable backspacing in insert mode
set backspace=indent,eol,start

" Suppress netrw history
let g:netrw_dirhistmax=0

" Report the current mode
function ModeText(hlgroup)
	let curr_mode = mode()
	if curr_mode ==# "n"
		if a:hlgroup == 1
			return " NORMAL "
		else
			return ""
		endif
	elseif curr_mode ==# "i"
		if a:hlgroup == 2
			return " INSERT "
		else
			return ""
		endif
	elseif curr_mode ==# "R"
		if a:hlgroup == 2
			return " REPLACE "
		else
			return ""
		endif
	elseif curr_mode ==# "v"
		if a:hlgroup == 3
			return " VISUAL "
		else
			return ""
		endif
	elseif curr_mode ==# "V"
		if a:hlgroup == 3
			return " V-LINE "
		else
			return ""
		endif
	elseif curr_mode ==# "\<C-V>"
		if a:hlgroup == 3
			return " V-BLOCK "
		else
			return ""
		endif
	elseif curr_mode ==# "s"
		if a:hlgroup == 3
			return " SELECT "
		else
			return ""
		endif
	elseif curr_mode ==# "S"
		if a:hlgroup == 3
			return " S-LINE "
		else
			return ""
		endif
	elseif curr_mode ==# "\<C-S>"
		if a:hlgroup == 3
			return " S-BLOCK "
		else
			return ""
		endif
	elseif curr_mode ==# "c"
		if a:hlgroup == 4
			return " COMMAND "
		else
			return ""
		endif
	elseif curr_mode ==# "r"
		if a:hlgroup == 4
			return " PROMPT "
		else
			return ""
		endif
	else
		if a:hlgroup == 5
			return " MODE: " . curr_mode . " "
		else
			return ""
		endif
	endif
endfunction

" Report the number of bytes in the buffer as a binary multiple
function BufferBytes()
	let bytes = wordcount().bytes
	if bytes < 1024
		return printf("[%d B]", bytes)
	elseif bytes < 1048576
		return printf("[%.1f KiB]", bytes / 1024.0)
	else
		return printf("[%.1f MiB]", bytes / 1048576.0)
	endif
endfunction

" Define custom highlight groups
highlight User1 cterm=bold ctermbg=34 ctermfg=16
                \ gui=bold guibg=#00af00 guifg=#000000
highlight User2 cterm=bold ctermbg=226 ctermfg=16
                \ gui=bold guibg=#ffff00 guifg=#000000
highlight User3 cterm=bold ctermbg=172 ctermfg=16
                \ gui=bold guibg=#d78700 guifg=#000000
highlight User4 cterm=bold ctermbg=198 ctermfg=16
                \ gui=bold guibg=#ff0087 guifg=#000000
highlight User5 cterm=bold ctermbg=160 ctermfg=15
                \ gui=bold guibg=#d70000 guifg=#ffffff
highlight WarnChar ctermbg=93 guibg=#8700ff

" Highlight trailing whitespace and non-ASCII characters in all windows
autocmd BufWinEnter * match WarnChar /\s\+$\|[^\x00-\x7f]/
autocmd BufWinLeave * call clearmatches()

" Interpret SCons files as Python scripts
autocmd BufRead,BufNewFile SCons* set filetype=python

" Enable cursor movement through wrapped lines for some modes
nnoremap <expr> j (v:count == 0 ? "gj" : "j")
nnoremap <expr> k (v:count == 0 ? "gk" : "k")
nnoremap <expr> <Down> (v:count == 0 ? "gj" : "<Down>")
nnoremap <expr> <Up> (v:count == 0 ? "gk" : "<Up>")
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
