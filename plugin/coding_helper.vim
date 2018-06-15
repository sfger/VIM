autocmd BufEnter *				let @p = expand('%:p') ? expand('%:p') : getcwd()
autocmd BufEnter *.wxml			let @q = "{{}}"
autocmd BufNewFile *.html       :L html
autocmd FileType java           setl dictionary+=$HOME\vimfiles\keyword\list\java.list
autocmd FileType php            setl dictionary+=$HOME\vimfiles\keyword\list\php.list
autocmd FileType c,C,cpp        setl dictionary+=$HOME\vimfiles\keyword\list\cpp.list
autocmd FileType css,lett,scss,sass        setl dictionary+=$HOME\vimfiles\keyword\list\css.list
autocmd FileType javascript,xhtml,html,htm,wxml setl dictionary+=$HOME\vimfiles\keyword\list\js.list
imap <C-CR> <C-x><C-k>

map \at :call AppendTime()<CR>
"AppendTime{{{
func AppendTime(...)
  "let format = '%Y-%m-%d %H:%M:%S'
  "let editinfo = ['/* File name: '.expand('%'),
  "\' * Last modified time: '.strftime(format,getftime(expand("%:p"))),
  "\' * Edit time: '.strftime(format,localtime()),
  "\' */']
  "call append(line('.'),editinfo)
  let l:tmp = system('ftime '.expand('%'))
  let l:line = split(l:tmp, "\n")
  if( len(l:line)==1 ) | echo l:line[0] | return '' | endif
  let l:ret = ['/* File name: '.l:line[0],
        \' * Author: DuJia',
        \' * Editor: Vim',
        \' * Created time: '.l:line[2],
        \' */']
  call append(line('.'), l:ret)
endfunc
"strftime('%Y-%m-%d %H:%M:%S',getftime(expand("%:p")))
"}}}

com -nargs=1 B call BlockString(<q-args>)
"BlockString{{{
func BlockString(...)
  let sel = get(a:000,0)
  if sel == 'js'
    exec "normal A\n".'<script type="text/javascript">'."\n".'//<![CDATA['."\n\<Esc>S".'//]]>'."\n\<Esc>S".'</script>'."\<Esc>kk"
  elseif sel == 'pop'
    exec "normal A\n\<Esc>S".'$(".popupBox").dialog({ autoOpen:false, title:"Test", width:700, height:450, modal:true, resizable:true });'."\n\<Esc>S".'$(".btn").click(function(){ $(".popupBox").dialog("open"); });'
  elseif sel == 'fs'
    exec "normal A\n".'/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */'
  else
    return -1
  endif
endfunc
"}}}

com -nargs=* I call EchoString(<f-args>)
"EchoString{{{
func EchoString(...)
  let args = a:000
  let sel = get(args,0)
  if sel == 'ptag'
    exec "normal i<?php\n?>\<Esc>hh"
  elseif sel == "pfunc"
    if get(args,1)==""
      echo "Function name must be specified!"
      return -1
    endif
    let argv = copy(args)
    call remove(argv,0,1)
    call map(argv,'"$".v:val')
    let argstr = join(argv,', ')
    exec "normal ofunction ".get(args,1)."(".argstr."){\n}"
  elseif sel == "piecho"
    exec "normal i<?php echo $".get(args,1)."; ?>\<Esc>hhh"
  elseif sel == "poecho"
    exec "normal o<?php echo $".get(args,1)."; ?>\<Esc>hhh"
  elseif sel == "peach"
    let key = get(args,2)
    if key == ''
      echo 'A variable must be specified!'
      return -1
    else
      let value = get(args,3)
      if value == ''
        let value = key
        exec "normal o<?php foreach(".get(args,1)." as ".value."){ ?>\n<?php } ?>\<Esc>kww"
      else
        exec "normal o<?php foreach(".get(args,1)." as ".key."=>".value."){ ?>\n<?php } ?>\<Esc>kww"
      endif
    endif
  elseif sel == "pshow"
    exec "normal oprint_r(".get(args,1).");\ndie;\<Esc>"
  elseif sel == "pdump"
    exec "normal ovar_dump(".get(args,1).");\ndie;\<Esc>"
  elseif sel == "pclass"
    if get(args,2) == ''
      let base = ''
    else
      let base = ' extends '.get(args,2)
    endif
    exec "normal aclass ".get(args,1).base." {\n}\<Esc>"
  elseif sel == "iframe"
    exec "normal o".'<iframe style="height:100%;width:100%;" frameborder="0" src=""></iframe>'."\<Esc>"
  else
    return -1
  endif
endfunc
"}}}

com -nargs=1 L call LoadModel(<q-args>)
"LoadModel{{{
func! LoadModel(...)
  let ft = get(a:000,0)
  let lines = line(".") - 1
  let ds = '/'
  let dir = '.vim'
  if g:os == 'win'
    let ds = '\'
    let dir = 'vimfiles'
  endif
  let $VIM_TEMP = $HOME.ds.dir.ds.'keyword'.ds.'load'
  let items = {'xhtml':	'default.html',
        \'html':	'html5.html',
        \'c':		'init.c',
        \'C':		'init.cpp',
        \'link':	'time_link.php',
        \'chart':	'chart.php',
        \'v':		'view.php',
        \'ctrl':	'ctrl.php',
        \}
  if has_key(items, ft)
    let file = items[ft]
  elseif getftype($VIM_TEMP . ds . ft) == 'file'
    let file = ft
  else
    return ''
  endif

  exec(':'.lines.'r $VIM_TEMP'.ds.file)
  "delete the empty line when loading file the cursor at
  "exec "normal k"
  "if getline( line(".") )=='' && lines==1
  "exec "normal dd"
  "endif
endfunc
"}}}

"map \fs :call FileSet()<CR>
"FileSet{{{
"func FileSet(...)
"let @z = '/* vim: set fdm=marker tabstop=4 shiftwidth=4 softtabstop=4: */'
"exec "pu! z"
"exec ":call append(line('.'),@z)"
"endfunc
"}}}

" vim: set fdm=marker :
