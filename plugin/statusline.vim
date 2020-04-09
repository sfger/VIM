" Summary:     Beautify statusline
" Description:
"         This script is based on the light2011 colorscheme. Thanks for xiaohuyee <xiaohuyee@gmail.com>
"         to give us such a pretty gift. He did most of the work. I just
"         stood on his shoulders.
"         I am looking for a beautiful vim statusline for a long time but found nothing
"         until I met the light2011.
"         Last night I spent several hours to beautify my statusline, it looks good.
"         And now I give it to you.
" Screenshot: 
"         http://vimer.1063083.n5.nabble.com/beautiful-vim-statusline-td4777850.html
"         
" Maintainer: Tian Huixiong: <nedzqbear@gmail.com>
"             I'm very glad to receive your feedback. 
" Licence:    This script is released under the Vim License.
" Version:    1.0
" Update:     2011-09-07 
" Install:     
"         Put this file in ~/.vim/plugin on *nix.
"         Or put it in $vim/vimfiles/plugin on Windows.
" Tutorial:
"         Just use it, and change it.
"         When you edit it, do not erase trailing-blanks.

let branch = trim(system('git rev-parse --symbolic --branches'))
set laststatus=2
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set statusline=
set statusline+=%2*\ %{branch}\ 
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
"hi User5 guifg=#002600  guibg=#67ab6e gui=italic
hi User5 guifg=#002600  guibg=#67ab6e
