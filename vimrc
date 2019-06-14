call plug#begin('~/plugged/')
Plug 'artur-shaik/vim-javacomplete2'
Plug 'brooth/far.vim'
Plug 'dkprice/vim-easygrep'
" Plug 'Valloric/YouCompleteMe'
" Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
" Plug 'mattn/emmet-vim', { 'for': ['javascript.jsx', 'html', 'css'] }
Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'
Plug 'tpope/vim-ragtag'
" Plug 'nikvdp/ejs-syntax'
" Plug 'briancollins/vim-jst'
" Plug 'gregsexton/MatchTag'
Plug 'plasticboy/vim-markdown'
" Plug 'sheerun/vim-polyglot'
" Plug 'vim-scripts/matchit.zip'
Plug 'andymass/vim-matchup'
Plug 'vim-scripts/taglist.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-scripts/vcscommand.vim'
Plug 'tpope/vim-fugitive'
" Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'heavenshell/vim-jsdoc'
Plug 'groenewege/vim-less'
Plug 'terryma/vim-multiple-cursors'
Plug 'posva/vim-vue'
Plug 'vim-scripts/YankRing.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }
Plug 'rhysd/vim-clang-format'
Plug 'dart-lang/dart-vim-plugin'
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

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
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
" }}}

"g:os{{{
let g:os="unix"
if has("win32")
  let g:os="win"
elseif has('mac')
  let g:os="mac"
endif
"}}}

" set group{{{
" top{{{
call pathogen#infect()
filetype plugin on
set cm=blowfish2
set noundofile nocompatible
" set tags=./tags,tags
set tags=tags;
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
" set fileencodings=GB2312,utf-8,gbk,ucs-bom,GB8030,default,latin
" set fileformats=dos,unix
" set encoding=utf-8
set fileencodings=utf-bom,utf-8,gbk,gb2312,gb18030,cp936,latin1
" set termencoding=utf-8
set ff=unix ffs=unix,dos,mac
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
" set cursorline cursorcolumn
" hi cursorline guibg=grey8 term=bold
set ph=15
hi Pmenu guibg=purple guifg=white
hi Pmenusel guibg=green guifg=black term=bold
hi conceal guibg=green guifg=black term=bold

hi Folded guifg=Yellow guibg=DarkGreen
hi lin phpheredoc string
hi normal guibg=black guifg=white
set nu ai nobackup guifont=consolas:h16
set autoindent smartindent autochdir
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set mouse=a selection=exclusive selectmode=mouse,key
set guioptions=EgrLt
set wildmenu
set whichwrap=b,s,<,>,[,]
set ambiwidth=double
set noswapfile
set diffopt=context:5
set scrolloff=0
set invpaste paste
" nnoremap :set invpaste paste? imap :set invpaste paste? set pastetoggle=
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
if has("win32")
  autocmd GUIEnter * simalt ~x
  map <C-Up> :simalt ~x<CR>
  map <C-Down> :simalt ~r<CR>
endif
map ,n :tabnew<CR>

map vv ^v$
map <C-M-Down>    <C-w>-
map <C-M-Up>      <C-w>+
map <C-M-Left>    <C-w><
map <C-M-Right>   <C-w>>
map <silent> <C-S-Left>  :let tmp = tabpagenr()-2 <Bar> if -1==tmp <Bar> tabm <Bar> else <Bar> exec("tabm ".tmp) <Bar> endif<CR>
map <silent> <C-S-Right> :let tmp = tabpagenr() <Bar> if tmp==tabpagenr("$") <Bar> tabm 0 <Bar> else <Bar> exec("tabm ".(tmp+1)) <Bar> endif<CR>

nnoremap <A-Up> :ALEPrevious<CR>
nnoremap <A-Down> :ALENext<CR>
nnoremap <S-Left>  :tabp<CR>
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
nmap <C-f>  <PageDown>
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
cnoremap <C-a>  <home>
cnoremap <C-e>  <end>
cnoremap <C-b>  <left>
cnoremap <C-f>  <right>
cnoremap <A-b>  <S-left>
cnoremap <A-f>  <S-right>
cnoremap <C-p>  <up>
cnoremap <C-n>  <down>
cnoremap <C-d>  <delete>
inoremap <C-a>  <home>
inoremap <C-e>  <end>
inoremap <C-b>  <left>
inoremap <C-f>  <right>
inoremap <A-b>  <C-left>
inoremap <A-f>  <C-right>
inoremap <C-d>  <delete>
inoremap <A-d>  <C-o>dw
inoremap <C-Backspace>  <C-o>b<C-o>dw
" inoremap <C-k>  <C-o>d$
" inoremap <C-u>  <C-o>d^
set cedit=<C-x>
" }}}Emacs map
" }}}

" Tlist{{{
map \tt :TlistToggle<CR>
map <S-Up> :TagbarToggle<CR>
" let Tlist_Ctags_Cmd = 'D:d\ShellAlias\ctags.exe'
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
let NERDTreeIgnore=['\.exe$','\.class$','\.gif$','\.png$','\.jpeg$','\.swf$','\.ttc$','^CVS$','^SVN$']
" }}}

" Char operation{{{
map <C-Left> "+<gvhhhh
map <C-Right> "+>gv
vn <C-c> "+ygv
" o||O for going to the other end of selections text 
map \src :source $HOME\vimfiles\vimrc<CR>
map \vim :tabnew $HOME\vimfiles\vimrc<CR>
map \dsl :g/^[ \t]*$/d<CR>
map \dse :%s/[ \t]*$//g<CR>
map \t2s :%s/\t/  /g<CR>
map \s2t :%s/  /\t/g<CR>
map \lcd :lcd %:p:h<CR>
if g:os=='win'
  map <silent> \xpr :call system('explorer "'.expand('%:p:h').'"')<CR>
elseif g:os=='mac'
  map <silent> \xpr :call system('open "'.expand('%:p:h').'"')<CR>
endif
" map <silent> <S-Down> :call system('cmd /c start')<CR>
map <silent> <S-Down> :call system('conemu '.expand('%:p:h'))<CR>
map <silent> \cmd <S-Down>
" }}}
" nmap <F4> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
" nmap <S-F4> :echo synIDattr(synID(line("."), col("."), 0), "name")<CR>
" Delete the swap file
" nmap \\. :echo strpart("Error  Deleted",7*(0==delete(expand("%:p:h")."/.".expand("%:t").".swp")),7)<cr>
" }}}

:ab beautify /* beautify preserve:start */<CR>/* beautify preserve:end */

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
          \ {'key': 'arrow', 'val': '<!--[if lt IE 8]><p class="before"></p><p class="after"></p><![endif]-->'},
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
  let ttt='ff'
  if g:os=='mac'
    let ttt='open'
  endif
  :call system(ttt.' http://www.iciba.com/'.word)
endfunc
com! -nargs=* Dic call Dictionary(<f-args>)
map ,d :let tmp = expand('<cword>') <Bar> exec("Dic ".tmp)<CR>
" }}}

func! Myman()
  let word = expand("<cword>")
  echo word
  exec "tab h ".word
endfunc
map K :call Myman()<CR>

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

autocmd FileType java            setlocal omnifunc=javacomplete#Complete
autocmd FileType java            imap <C-u> <C-x><C-o><C-p>

let g:typescript_compiler_options = '-sourcemap'
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
autocmd BufEnter *.conf         set ft=conf
autocmd BufEnter *.tsx          set ft=typescript
autocmd BufEnter *.ejs          set ft=ejs.html
autocmd BufEnter *.tpl          set ft=ejs.html
autocmd BufEnter *.vue          set ft=javascript.css.html.vue

autocmd BufEnter *.wxss         set ft=css
autocmd BufEnter *.wxml         set ft=ejs.html
autocmd BufEnter *.wpy          set ft=html.vue
autocmd BufEnter *.wxs          set ft=javascript
autocmd BufEnter *.mjs          set ft=javascript

autocmd BufEnter *.js           set suffixesadd=.js,.mjs,.scss,.css
autocmd BufEnter *.ejs          set suffixesadd=.ejs

syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

let g:jsx_ext_required = 1
let g:rust_recommended_style = 0
" C-x C-t
set thesaurus=$HOME\vimfiles\keyword\list\en.list
" set path=.,.\**,E:\ShellAlias\GccDir\MinGW\include
set path=.,E:\ShellAlias\GccDir\MinGW\include
set fdm=marker
nmap <silent> \host :tabnew C:\Windows\System32\drivers\etc\hosts<CR>
nmap \fd :NERDTreeFind<CR>
let g:JavaComplete_MavenRepositoryDisable = 1
autocmd BufEnter * set iskeyword=@,48-57,_,$,-,192-255
" set ballooneval
" vim: fdm=marker

set spell
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let g:ale_linters = {
  \'javascript': ['eslint', 'prettier'],
  \'typescript': ['eslint', 'prettier'],
  \'html': [ 'HTMLHint', 'proselint', 'prettier', 'tidy', 'eslint' ]
\}
let g:ale_fixers = {
  \'javascript': [ 'prettier', 'eslint' ],
  \'typescript': [ 'prettier', 'eslint' ],
  \'java': [ 'google_java_format' ]
\}
let g:ale_java_google_java_format_executable = "D:/projects/sa/google-java-format-1.7-all-deps.jar"
let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en'
" let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"在vim自带的状态栏中整合ale
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
" let g:javascript_plugin_ngdoc = 1
" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END
set conceallevel=1 "concealcursor=niv
" let g:javascript_conceal_function             = "f"
" let g:javascript_conceal_this                 = "@"
" let g:javascript_conceal_prototype            = "¶"
" let g:javascript_conceal_null                 = "ø"
" let g:javascript_conceal_return               = "R"
" let g:javascript_conceal_undefined            = "¿"
" let g:javascript_conceal_NaN                  = "ℕ"
" let g:javascript_conceal_static               = "•"
" let g:javascript_conceal_super                = "Ω"
let tern_show_signature_in_pum = 1
let tern_show_argument_hints = 'on_hold'
autocmd FileType javascript nnoremap <leader>d :TernDef<CR>
" let mapleader="\\"
let maplocalleader=","
" autocmd FileType javascript setlocal omnifunc=tern#Complete

let g:user_emmet_install_global = 0
let g:user_emmet_settings = { 'javascript.jsx': { 'extends': 'jsx' } }
autocmd FileType ejs.html,html,css,javascript.jsx EmmetInstall

let g:ale_python_pylint_executable = 'python3'
let g:matchup_matchparen_status_offscreen = 0

" let dart_format_on_save = 1

command -range=% -nargs=* Test :echo GetSelectText(<line1>, <line2>)
func GetSelectText(line1, line2)
  return join(getline( a:line1, a:line2 ), "\n")
endfunc
