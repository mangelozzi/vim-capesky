" Hex colour codes with matching closest terminal color
function! s:xterm_fromRgb_test()
    let tests = [
                \['#000000', 16],
                \['#5f8700', 64],
                \['#ffffff', 231],
                \['#eeeeee', 255],
                \['#5a858c', 66],
                \['#dad7d8', 188],
                \['#afb1b2', 249],
                \['#af009b', 127],
                \['#4b4b4b', 239],
                \['#171717', 234],
                \['#739beb', 111],
                \]

    for test in tests
        let correct_hex   = test[0]
        let correct_xterm = test[1]
        let rgb = capesky#t_hex#toRgb(correct_hex)
        let test_xterm = capesky#t_xterm#fromRgb(rgb)
        let result = (correct_xterm == test_xterm) ? 'OK' : 'FAIL'
        echom printf("t_xterm#fromRgb('%s') -> %3d == %3d ? %s", correct_hex, correct_xterm, test_xterm, result)
        if result == 'FAIL'
            echom correct_hex
        endif
    endfor
    echom
endfunction
call s:xterm_fromRgb_test()

function! s:t_xterm_toRgb_test()
    let tests = [
                \['#000000', 16],
                \['#5f8700', 64],
                \['#ffffff', 231],
                \['#eeeeee', 255],
                \['#5f8787', 66],
                \['#d7d7d7', 188],
                \['#b2b2b2', 249],
                \['#af00af', 127],
                \['#4e4e4e', 239],
                \['#1c1c1c', 234],
                \['#87afff', 111],
                \]

    for test in tests
        let correct_hex   = test[0]
        let correct_xterm = test[1]
        let rgb = capesky#t_xterm#toRgb(correct_xterm)
        let test_hex = capesky#t_hex#fromRgb(rgb)
        let result = (correct_hex == test_hex) ? 'OK' : 'FAIL'
        echom printf("t_xterm#toRgb(%3d) -> %s == %s ? %s", correct_xterm, correct_hex, test_hex, result)
    endfor
    echom
endfunction
" call s:t_xterm_toRgb_test()
