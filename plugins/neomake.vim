" Run lint when save [Ctrl+w]
" call neomake#configure#automake('w')

let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint']

nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning
