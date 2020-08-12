call capesky#init()

command! CapeskyPrev :call capesky#changeindex(-1)
command! CapeskyNext :call capesky#changeindex(1)

nnoremap <silent> <M-1> :CapeskyPrev<CR>
nnoremap <silent> <M-2> :CapeskyNext<CR>

