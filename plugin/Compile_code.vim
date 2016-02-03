func! Compile()
	if 'c' == &ft
		" let makeprg = 'set makeprg=gcc\ -Wall\ -o\ ' . expand("%:r") . '\ %'
		let makeprg = 'set makeprg=gcc\ -Wall\ -o\ a\ %'
	elseif 'cpp' == &ft
		" let makeprg = 'set makeprg=g++\ -Wall\ -o\ ' . expand("%:r") . '\ %\ -Wl,--enable-auto-import'
		let makeprg = 'set makeprg=g++\ -Wall\ -o\ a\ %\ -Wl,--enable-auto-import'
	elseif 'java' == &ft
		let makeprg = 'set makeprg=javac\ ' . expand("%")
		set shellpipe=>\ %s\ 2>&1
		set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
		"set makeprg=jikes\ +E\ %
		"set errorformat=%f:%l:%v:%*\\d:%*\\d:%*\\s%m
	elseif 'php' == &ft
		let makeprg = 'set makeprg=php\ -l\ -n\ -d\ html_errors=off\ ' . expand("%")
		setlocal errorformat=%m\ in\ %f\ on\ line\ %l
	elseif 'javascript' == &ft
		let makeprg = 'set makeprg=jsl.bat\ process\ ' . expand("%")
	"elseif 'less' == &ft
		"let makeprg = 'set makeprg=lessc\ -x\ --no-color\ '.expand('%').' '.expand('%:r').'.css'
		"let l:errs = Cmd_Shell('lessc '.expand('%').' '.expand('%:r').'.css')
		"if (!empty(l:errs))
		  " replace the escape string(\%oxxx match the octal character).  e.g: \033[33m
		  "let l:errs = substitute(l:errs, "\\%o033[\\d\\+m", "", "g") 
		  " replace the blank lines
		  "let l:errs = substitute(l:errs, "^$", "", "g")
		  " we jsut need the error message
		  "let l:errs = split(l:errs, "\\n")[0]
		  "echo l:errs
		"endif
		"return ''
	else
	endif

    silent! exe makeprg
    silent! exe ':update'
	silent! exe ':make'

    call HideOutput()
    call Quickfix()
endfunc

func! Quickfix()
    let list = getqflist()
    let bugs = len(list)

    if bugs == 0
        echo 'Compile success!'
        " Hide the quickfix window
        silent! exe 'cw'
        "call Run()
    else
		if('php' == &ft && 'No syntax errors detected in '.expand("%") == list[0].text)
			echo 'Syntax check success!'
			silent! exe 'cw'
		else
			echo 'Fix bugs first.'
			" Show the quickfix window
			silent! exe 'cw ' . string((bugs + 1) > 9 ? 9 : (bugs + 1))
		endif
    endif
endfunc

func! HideOutput()
    let output_file = string(getpid()) . '.output'
    let bufnumlist  = tabpagebuflist()

	:ccl
    for bufnum in bufnumlist
        let file = bufname(bufnum)
        if file =~# output_file
            silent! exe string(bufnum) . ' bwipe!' 
            break
        endif
    endfor

    silent! exe ':setlocal laststatus=2'
endfunc

func! Run()
    call HideOutput()
    
	let l:ft = &ft
	let l:ff = &ff
    let src_winnr = winnr()
	let bin_file = expand("%:r")

	" if l:ft=='c' && executable(expand("%:p:r") . '.exe') != 1 | echo bin_file . '.exe does not exist!' | return '' | endif
	if l:ft=='c' && executable('a.exe') != 1 | echo 'a.exe does not exist!' | return '' | endif
	if l:ft=='java' && getftype(bin_file. '.class')!='file' | echo bin_file . '.class does not exist!' | return '' | endif

	call Split_below()
	if 'c'==l:ft || 'cpp'==l:ft
		" silent! exe '%!' . bin_file
		silent! exe '%!a'
	elseif 'php'==l:ft
		silent! exe '%!php ' . bin_file . '.php'
	elseif 'java'==l:ft
		silent! exe '%!java ' . bin_file
	" elseif 'javascript'==l:ft
	elseif -1!=index(split(l:ft, '\.'), 'javascript')
		silent! exe '%!node ' . bin_file . '.js'
	elseif 'less' == l:ft
		silent! exe '%!lessc -x --no-color '.bin_file.'.less '.bin_file.'.css'
	elseif 'scss' == l:ft
		silent! exe '%!node-sass --output-style compact '.bin_file.'.scss'
	endif

    silent! exe src_winnr . 'wincmd w'
endfunc

autocmd FileType c,cpp,java,php,javascript nnoremap <buffer><silent> ,c :call Compile()<cr>
autocmd FileType c,cpp,java,php,javascript,less,scss nnoremap <buffer><silent> ,r :call Run()<cr>
autocmd FileType c,cpp,java,php,tmp,qf,javascript,less,scss nnoremap <buffer><silent> ,h :call HideOutput()<cr>
autocmd FileType * set autoindent smartindent autochdir
