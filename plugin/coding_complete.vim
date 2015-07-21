"CompleteCoding{{{
func! CompleteCoding(pos,key)
    if a:pos
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        let l:match = ["main","http-equiv","match","morning"]
        for k in l:match
            if k =~ '^'.a:key
                call complete_add(k)
            end
            if complete_check()
                break
            endif
        endfor
        return []
    endif
endfun
set completefunc=CompleteCoding
"}}}
imap <C-u> <C-x><C-u>

map <C-S-CR> :call CodeComplete()<CR>
"CodingComplete{{{
function! CodeComplete()
    let l:opts = expand('<cword>')
    if 'show' == l:opts
        exec "normal bcw<?=$?>\<Esc>h"
    elseif 'if' == l:opts
        exec "normal bcw<?php if( $ ){ ?>\n<?php } ?>\<Esc>bbb%hh"
    elseif 'each' == l:opts
        exec "normal bcw<?php foreach($){ ?>\n<?php } ?>\<Esc>bb%h"
    endif

    return ''
endfunction
"}}}

imap <C-S-CR> <C-R>=CodingComplete()<CR><Right>
"imap <C-S-CR> <Esc>:call JavaComplete()<CR>

"Str_trim{{{
function! Str_trim(...)
    if 1 == a:0
        let l:ret = substitute(a:1, '^\s*\|\s*$', "", "g")
    elseif 2 == a:0
        let l:ret = substitute(a:1, '^'.a:2.'\|'.a:2.'$', "", "g")
    elseif 3 == a:0
        if 'l' == a:3
            let l:ret = substitute(a:1, '^'.a:2, "", "g")
        elseif 'r' == a:3
            let l:ret = substitute(a:1, a:2.'$', "", "g")
        endif
    endif
    return l:ret
endfunction
"}}}

"Get_line_option{{{
function! Get_line_option( line )
    let l:line = substitute(a:line, '\s\{1,}', " ", "g")
    let l:line = Str_trim(l:line)
    let l:line = substitute(l:line,'\s*=\s*', " = ", "")
    let l:opts = split(l:line,' ')
    return l:opts
endfunction
"}}}

"CodingComplete{{{
function! CodingComplete()
    let l:opts = Get_line_option( getline('.') )
    let l:n = len(l:opts)
    if 0 == l:n | return '' | endif

    "General start
	"echo l:opts | return ''
    if 'fn' == l:opts[n-1] | exec "normal bDafunction(){\n}\<Esc>ba" | endif
	if 'fn,' == l:opts[n-1] | exec "normal bbDafunction(){\n},\<Esc>bba" | endif
	if 'fn;' == l:opts[n-1] | exec "normal bbDafunction(){\n};\<Esc>bba" | endif
    if l:n >  1
        if 'fn' == l:opts[n-2] | exec "normal bbDafunction ".opts[n-1]."(){\n}\<Esc>ba" | endif
    endif
	if 'cl' == l:opts[0] && l:n==1 | exec "normal Sconsole.log();\<Esc>ba" | endif
	if 'cl' == l:opts[0] && l:n==2 | exec "normal Sconsole.log(".l:opts[1].");" | endif
    "General end

    "PHP start
    if 'if' == l:opts[0]
        exec "normal a(  ){\n}\<Esc>%bbl"
    endif
    if 'each' == l:opts[n-2]
        exec "normal Sforeach($".l:opts[n-1]." as $) {\n}\<Esc>bb"
    elseif 'date' == l:opts[n-1]
        exec "normal a('Y-m-d');\<Esc>bha"
    elseif 'last_month' == l:opts[n-1]
        exec "normal bcwdate('Y-m'.'-01', strtotime(date('Y-m'.'-01'))-86400);"
    endif
	if len(l:opts)==3 && 'sql'==l:opts[0] && 'in'==l:opts[1]
		exec "normal S$in = array_fill(0, count($".l:opts[2]."), '?');\n$in = join($in, ',');"
	endif
    "PHP end

    "HTML start
    if 'iframe' == l:opts[0] && n == 1
        exec "normal S".'<iframe style="height:100%;width:100%;" frameborder="0" src=""></iframe>'."\<Esc>F\"h"
        return ''
    endif
    "HTML end

    "JAVA start
    if 1 == n
        if 'main' == l:opts[0]
            exec "normal Spublic static void main(String args[]){\n}\<Esc>kA"
        elseif 'echo' == l:opts[0]
            exec 'normal SSystem.out.println("");'."\<Left>\<Left>\<Left>"
        endif
    elseif 2 == n
    elseif 3 == n
        if 'in' == l:opts[0]
            exec "normal SScanner ".l:opts[1]." = new Scanner(System.in);"
            exec "normal oString ".l:opts[2]." = ".l:opts[1].".next();"
        endif
        if "=" == l:opts[2]
            exec "normal S".l:opts[0].' '.l:opts[1].' = new '.l:opts[0]."();"."\<Left>\<Left>"
        endif
    endif
    "JAVA end

    return ''
endfunction
"}}}

" vim: set fdm=marker :
