com! -nargs=* -range=0 -complete=file C call Run_cmd(<q-args>, '__shell__')

func! Split_below(...)
  let l:ff = &ff
  let l:output_file = string(getpid()) . '.output'
  "redir => sb_message | silent! set sb? | redir END
  "let sb_message = 'set '. substitute(sb_message, '^\W\s*', '', '')
  :set splitbelow
  silent! exe '15split ' . l:output_file
  silent! exe ':set buftype=nofile filetype=tmp ff='.l:ff
endfunc
func! Run_cmd(...)
  call Split_below()
  ":set nosplitbelow
  let ret = Cmd_Shell(join(a:000, ' '))
  let tmp = split(ret, '\n')
  let tmp = reverse(tmp)
  for l:item in tmp
    :call append(0, l:item)
  endfor
  exec 'normal dd'
  "silent! set sb_message
endfunc

"Build-in functions
"if (has("win32"))
"com! -nargs=0 Date call Cmd_Shell("date /t", <q-args>)
"else
"com! -nargs=0 Date call Cmd_Shell("date", <q-args>)
"endif
"com! -nargs=* Ls call Cmd_Shell("ls", <q-args>)
"com! -nargs=0 Xpr call Cmd_Shell("explorer",expand("%:p:h"))
"com! -nargs=0 Start call Cmd_Shell("cmd /c start")

function Cmd_Shell(...)
  let cmd = join(a:000," ")
  let arg = split(cmd, ' ')
  let n = len(arg)
  let is_shell = arg[n-1]
  if is_shell=='__shell__'
    call remove(arg, n-1)
  endif
  let cmd = join(arg, ' ')
  "echo getcwd().'>'.cmd | return ''
  let out = system(cmd)
  if &enc == "utf-8" && is_shell=='__shell__'
    " let out = iconv(out, "utf8", "cp936")
    let out = iconv(out, "cp936", "utf8")
  endif
  if out!=''
    return out
  endif
  return ''
endfunc

map <F5> :Run<CR>
com -nargs=* Run call RunNew(<q-args>)
func RunNew(...)
  if bufname('') =~? "\.php$"
    exec "!php %"
  elseif bufname('') =~? "\.js$"
    exec "!node %"
  elseif bufname('') =~? "\.java$"
    exec "!javac %"
    exec "!java %<"
  elseif bufname('') =~# "\.c$"
    if get(a:000,0) == ''
      exec "!gcc %"
    else
      exec "!gpp %"
    endif
    exec "!a"
  elseif bufname('') =~# "\.C$\\|\.cpp$"
    exec "!gpp %"
    exec "!a"
  else
    return -1
  endif
endfunc

map <F8> :RunInVim<CR>
com -nargs=* RunInVim call RunSmart(<q-args>)
func RunSmart(...)
  let name = bufname('')
  if name =~? "\.php$"
    echo Cmd_Shell("php",expand("%"))
  elseif name =~? "\.html$" || name =~? "\.htm$"
    "echo Cmd_Shell("ff",'"'.expand("%:p").'"')
    echo Cmd_Shell('"'.expand("%:p").'"')
  elseif name =~? "\.js$"
    echo Cmd_Shell("node",'"'.expand("%:p").'"')
  elseif name =~? "\.java$"
    echo Cmd_Shell("javac",expand('%'))
    echo Cmd_Shell("java",expand('%<'))
  elseif name =~# "\.c$"
    echo Cmd_Shell("gcc",expand('%'))
    echo Cmd_Shell("a")
  elseif name =~# '\.C$\|.cpp$'
    echo Cmd_Shell("gpp",expand('%'))
    echo Cmd_Shell("a")
  else
    return -1
  endif
endfunc
