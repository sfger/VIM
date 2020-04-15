func GetProjectBranch()
  let ret = trim(system( "git rev-parse --abbrev-ref HEAD" ))
  if ret == "fatal: not a git repository (or any of the parent directories): .git"
    let ret = ""
  endif
  " let list = split(ret, "\n")
  " let br = list[-1]
  return ret
endfunc

func SetBranchBar()
  let br = GetProjectBranch()
  if br != ""
    let br = "  " . br . " "
  endif
  return br
endfunc

let branch=""
autocmd BufEnter *  let branch=SetBranchBar()
set laststatus=2
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set statusline=
set statusline+=%2*%{branch}
set statusline+=%1*\ %{bufname('')==''?getcwd():expand('%:p')}%r%m\ 
"set statusline+=%2*\ %{&ff=='unix'?'\\n':(&ff=='mac'?'\\r':'\\r\\n')}\
set statusline+=%=%3*\ %{&ft==''?'txt':&ft}\ 
set statusline+=%2*\ %{&fenc}\|%{&ff}\ 
set statusline+=%5*\ %{&enc}\|%{v:lang}\ 
"set statusline+=%2*\ 0x%04.4B\|%05b\ 
set statusline+=%1*\ %P\|%04l\|%03c\ 
"set statusline+=%1*\ %-16{strftime(\"%Y-%m-%d\ %H:%M:%S\")}\ 
"set statusline+=%1*\ %-16{strftime('%Y-%m-%d\ %H:%M:%S',getftime(expand('%:p')))}\ 

hi User1 guifg=#112605  guibg=#aefe7B
hi User2 guifg=#391100  guibg=#008019
hi User3 guifg=#292b00  guibg=#f2f597
hi User4 guifg=#051d00  guibg=#7dcc7d
hi User5 guifg=#002600  guibg=#67ab6e
