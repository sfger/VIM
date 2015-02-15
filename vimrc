" Original _vimrc{{{
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set diffexpr=MyDiff()
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '"' . $VIMRUNTIME . '\diff"'
            let eq = '""'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\dif"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
" }}}

" set group{{{
" top{{{
call pathogen#infect()
filetype plugin on
set nocompatible
set tags=./tags,tags
" set tags=./tags,tags,E:/Projects/tags
" }}}

" encoding set{{{
set encoding=UTF-8
setlocal langmenu=zh_CN.UTF-8
language messages zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
if bufname('')==''
    cd $HOME
    set fileencoding=utf-8
endif
set fileencodings=GB2312,utf-8,gbk,ucs-bom,GB8030,default,latin
set fileformats=dos,unix
" set encoding=utf-8
set fileencodings=utf-bom,utf-8,gbk,gb2312,gb18030,cp936,latin1
" set termencoding=utf-8
" }}}

" Backup{{{
" dig reg args buffers q:
" set spell spelllang=en
" z=
" set list
" set listchars=tab:>-,trail:-
" :r! sed -n "2,3p" filename
" 1,3w filename
" :args *.c
" :argdo set ff=unix | update

" :set bin noendofline
" :lcd %:p:h
" :set shellslash
" dir /s /b *.txt
" :set formatoptions=tcrqn
" :earlier 10m
" :later 10s
" :undolist
" :wall --write all change file
" :ball
" :tab ball

" if has('gui_running')
"   let do_syntax_sel_menu=1
" endif
" }}}

" common{{{
set cursorline "cursorcolumn
hi cursorline guibg=grey8 term=bold
set ph=15
hi Pmenu guibg=purple guifg=white
hi Pmenusel guibg=green guifg=black term=bold

hi	Folded	guifg=Yellow	guibg=DarkGreen
hi	lin	phpheredoc	string
:hi normal guibg=black guifg=white
set nu ai nobackup guifont=consolas:h16
set autoindent smartindent autochdir
set tabstop=4 softtabstop=4 shiftwidth=4 "expandtab
set mouse=a selection=exclusive selectmode=mouse,key
set guioptions=EgrLt
set wildmenu
set whichwrap=b,s,<,>,[,]
set ambiwidth=double
set noswapfile
set diffopt=context:5
" }}}

" Toggle show menu{{{
map <silent> <M-m> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T guioptions+=m <Bar>
    \endif<CR>
map <silent> <M-n> :if &guioptions =~# 'b' <Bar>
        \set nodiff noscrollbind guioptions-=b <bar>
    \else <Bar>
        \set diff scrollbind guioptions+=b <bar>
    \endif<CR>
" }}}
" }}}

" map group{{{
" window and tab map{{{
autocmd GUIEnter * simalt ~x
map <C-Up> :simalt ~x<CR>
map <C-Down> :simalt ~r<CR>
map <C-t> :tabnew<CR>

map <C-M-Down> <C-w>-
map <C-M-Up> <C-w>+
map <C-M-Left> <C-w><
map <C-M-Right> <C-w>>
map <silent> <C-S-Left> :let tmp = tabpagenr()-2 <Bar> if -1==tmp <Bar> tabm <Bar> else <Bar> exec("tabm ".tmp) <Bar> endif<CR>
map <silent> <C-S-Right> :let tmp = tabpagenr() <Bar> if tmp==tabpagenr("$") <Bar> tabm 0 <Bar> else <Bar> exec("tabm ".tmp) <Bar> endif<CR>

nnoremap <S-Left> :tabp<CR>
nnoremap <S-Right> :tabn<CR>
for a in range(1,9)
    exe 'map <A-' . a . '> ' . a . 'gt'
endfor
" }}}

" cscope{{{
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" }}}

" cursor amp{{{
" gm
map gn g^
" self define{{{
imap <silent> <A-h> <C-Left>
imap <silent> <A-l> <C-Right>
imap <silent> <A-j> <Down>
imap <silent> <A-k> <Up>

imap <silent> <C-h> <BS>
imap <silent> <C-l> <Del>
" imap <silent> <C-j> <C-o>b<C-o>dw
" imap <silent> <C-k> <C-o>dw
" }}}
" Emacs map{{{
cnoremap <C-a>	<home>
cnoremap <C-e>	<end>
cnoremap <C-b>	<left>
cnoremap <C-f>	<right>
cnoremap <A-b>	<S-left>
cnoremap <A-f>	<S-right>
cnoremap <C-p>	<up>
cnoremap <C-n>	<down>
cnoremap <C-d>	<delete>

inoremap <C-a>	<home>
inoremap <C-e>	<end>
inoremap <C-b>	<left>
inoremap <C-f>	<right>
inoremap <A-b>	<C-left>
inoremap <A-f>	<C-right>
inoremap <C-d>	<delete>
inoremap <A-d>	<C-o>dw
inoremap <C-Backspace>  <C-o>b<C-o>dw
" inoremap <C-k>  <C-o>d$
" inoremap <C-u>  <C-o>d^
set cedit=<C-x>
" }}}Emacs map
" }}}

" Tlist{{{
map \tt :TlistToggle<CR>
map <S-Up> :TlistToggle<CR>
let Tlist_Ctags_Cmd = 'E:\ShellAlias\ctags.exe'
let Tlist_Auto_Open=0
" let Tlist_Compact_Format = 1
" let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
let tlist_php_settings = 'php;c:class;d:constant;f:function'
let Tlist_WinWidth = 25
" }}}

" NERD{{{
map \nt :NERDTreeToggle<CR>
map <S-CR> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.exe$','\.gif$','\.png$','\.jpeg$','\.swf$','\.ttc$','^CVS$','^SVN$']
" }}}

" Char operation{{{
map <C-Left> "+<gvhhhh
map <C-Right> "+>gv
vn <C-c> "+ygv
" o||O for going to the other end of selections text 
map \src :source $home\vimfiles\vimrc<CR>
map \dsl :g/^[ \t]*$/d<CR>
map \dse :%s/[ \t]*$//g<CR>
map \t2s :%s/\t/    /g<CR>
map \s2t :%s/    /\t/g<CR>
map \lcd :lcd %:p:h<CR>
map <silent> \xpr :call system('explorer "'.expand('%:p:h').'"')<CR>
map <silent> <S-Down> :call system('cmd /c start')<CR>
map <silent> \cmd <S-Down>
" }}}
" nmap <F4> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
" nmap <S-F4> :echo synIDattr(synID(line("."), col("."), 0), "name")<CR>
" Delete the swap file
" nmap \\. :echo strpart("Error  Deleted",7*(0==delete(expand("%:p:h")."/.".expand("%:t").".swp")),7)<cr>
" }}}

" fn group{{{
" fn Adjust_fontsize{{{
func! Adjust_fontsize(...)
	let l:sel = get(a:000,0)
	let l:font = &gfn
	let l:temp = split(l:font, ':')
	let l:size = strpart(l:temp[1], 1)
	if l:size==1&&sel=='dec' | return | endif
	if l:size==30&&sel=='inc' | return | endif
	call remove(l:temp, 1)
	if l:sel=='inc'
		call add(l:temp, 'h' . ( 1 + l:size ))
	elseif l:sel=='dec'
		call add(l:temp, 'h' . ( -1 + l:size ))
	endif
	exec(':set guifont='.join(l:temp, ':'))
endfunc
nmap <silent> <A-+> :call Adjust_fontsize('inc')<CR>
nmap <silent> <A--> :call Adjust_fontsize('dec')<CR>
" }}}

" fn MY_abbreviate{{{
imap <C-TAB> <C-R>=MY_abbreviate()<CR><Right>
function! MY_abbreviate()
	let l:opts = Get_line_option( getline('.') )
	"php http{{{
	if 'html'==l:opts[0]
		for item in [ {'key': 'iecp', 'val': '<!--[if lt IE 8]><p class="iecp"></p><![endif]-->'},
					\]
			if item.key==l:opts[1]
				exec "normal S" . item.val
				return ''
			endif
		endfor
	endif
	if 'http'==l:opts[0]
		for item in [ {'key': 'text', 'val': 'header("Content-Type: text/plain; charset=GBK");'},
					\ {'key': 'length', 'val': 'header("Content-Length: 100");'},
					\ {'key': 'download', 'val': 'header("Content-Type: application/force-download");'},
					\ {'key': 'filename', 'val': 'header("Content-Disposition: attachment; filename=A.txt");'},
					\]
			if item.key==l:opts[1]
				exec "normal S" . item.val
				return ''
			endif
		endfor
	endif
	"}}}
	"php iconv{{{
	if 'iconv'==l:opts[0]
		if len(l:opts)==3 && 'r'==l:opts[2]
			exec "normal S$".l:opts[1]." = iconv('GBK', 'UTF-8//IGNORE', $".l:opts[1].");"
		else
			exec "normal S$".l:opts[1]." = iconv('UTF-8', 'GBK//IGNORE', $".l:opts[1].");"
			"exec "normal S$".l:opts[1]." = iconv('UTF-8', 'GB18030//IGNORE', $".l:opts[1].");"
		endif
	endif
	"}}}
	return ''
endfunction
" }}}

" fn Math_line{{{
func! Math_line(...)
	let sel = get(a:000, 0)
	let n = line('$')
	let ret = 0
	let lnum = 1
	if('sum'==sel)
		while lnum <= line("$")
			exec('let ret += '.getline(lnum))
			let lnum += 1
		endwhile
	elseif('avg'==sel)
		let ret = Math_line('sum')
		if(floor(ret)==ret)
			exec('let ret = '.ret.'.0/'.n)
		else
			let ret = ret / n
		endif
	elseif
		return ''
	endif
	return ret
endfunc
com! -nargs=* M echo Math_line(<f-args>)
" }}}

" fn GenerateInitTemplateCode{{{
com! -nargs=* G call GenerateInitTemplateCode(<f-args>)
func! GenerateInitTemplateCode(...)
	let sel = get(a:000, 0)
	let l:view = expand("%:r")
	if('c') == sel
		let l:temp = split(expand("%:p:h"), '\')
		let l:path = l:temp[-1]

		let l:class = Camelize(l:temp[-1] . '_' .l:view)
		:L ctrl
		" exec('normal 3ggwcw' . l:class . "\<Esc>5ggf'a" . l:view)
		exec('normal 2ggwcw' . l:class)
	elseif('java') == sel
		exec('normal ipublic class ' . l:view . "{\n}")
		exec("normal Omain\<C-S-CR>")
	else
	endif
	return ''
endfunc
" }}}

" fn Str2PHPArray{{{
func! Str2PHPArray(str)
	let l:tmp = split(a:str, "\n")
	let l:ret = []
	for l:item in l:tmp
		let l:item = substitute(l:item, '^\|$' , '"', 'g')
		let l:item = substitute(l:item, '\s\+', '" => "', 'g')
		echo add(l:ret, l:item)
	endfor
	return join(l:ret, "\n")
endfunc
vnoremap ,arr "zygv"=Str2PHPArray(@z)<CR>Pgv
" }}}

" fn Dictionary{{{
func! Dictionary(...)
	let word = get(a:000,0)
	:call system('ff http://www.iciba.com/'.word)
endfunc
com! -nargs=* Dic call Dictionary(<f-args>)
map <silent> <A-f> :let tmp = expand('<cword>') <Bar> exec("Dic ".tmp)<CR>
" }}}

" fn Camelize{{{
func! Camelize(str)
    let l:temp = split(a:str, '_')
    let l:ret = ''
    for l:a in l:temp
        let l:ret .= toupper(l:a[0]) . l:a[1:]
    endfor
    return l:ret
endfunc
" }}}

" fn TwiddleCase{{{
function! TwiddleCase(str)
	if a:str ==# toupper(a:str)
		let result = tolower(a:str)
	elseif a:str ==# tolower(a:str)
		let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
	else
		let result = toupper(a:str)
	endif
	return result
endfunction
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgvl
" }}}

" fn DirExplorer{{{
com! -nargs=* D call DirExplorer(<f-args>)
func! DirExplorer()
    let l:temp = system('ls')
    let l:line = split(l:temp, "\n")
    :call remove(l:line, 0, 4)
    :call remove(l:line, -2, -1)
    let l:ret = []
    for l:a in l:line
        let l:b = split(l:a, '\s\{1,}')
        for l:c in l:b
            let l:ret = add(l:ret, l:c)
        endfor
    endfor
    echo l:ret
    return ''
endfunc
" }}}

" fn Del_note{{{
function! Del_note()
	:%s/\s*\/\*\_.\{-}\*\///g
	:%s/\s*\/\/[^'"]*$//g
endfunction
" }}}

" fn GetSystem{{{
function! GetSystem()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction
" }}}

" fn SetColorColumn{{{
" set colorcolumn=80
map <silent> ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction
" }}}

" fn Toggle_charset{{{
nmap ,tr :call Toggle_charset()<CR>
function! Toggle_charset()
    if &encoding != 'utf-8'
        :setlocal encoding=utf-8
        :setlocal langmenu=zh_CN.UTF-8
        :language messages zh_CN.UTF-8
    else
        :setlocal encoding=cp936
        :setlocal langmenu=zh_CN.CP936
        ":language messages zh_CN.CP936
        :language messages zh_CN
    endif
endfunction
" }}}

" }}}

" Java{{{
if has("autocmd")
	autocmd FileType java            setlocal omnifunc=javacomplete#Complete
	autocmd FileType java            imap <C-u> <C-x><C-o><C-p>
endif
" }}}

let g:vimim_toggle='wubi'
let g:vimim_wubi='jd'
let g:vimim_mode = 'dynamic'
let g:vimim_map='c-bslash'
" C-x C-t
set thesaurus=$HOME\vimfiles\keyword\list\en.list
" set path=.,.\**,E:\ShellAlias\GccDir\MinGW\include
set path=.,E:\ShellAlias\GccDir\MinGW\include

nmap <silent> \host :tabnew C:\Windows\System32\drivers\etc\hosts<CR>
" function! MyBalloonExpr()
" 	return 'Cursor is at line ' . v:beval_lnum .
" 				\', column ' . v:beval_col .
" 				\ ' of file ' .  bufname(v:beval_bufnr) .
" 				\ ' on word "' . v:beval_text . '"'
" endfunction
" set bexpr=MyBalloonExpr()
" set ballooneval
" vim: fdm=marker
