" Hex colour codes with matching RGB objects color
let s:tests = [
            \['#000000', {'r': 0x00, 'g':0x00, 'b':0x00}],
            \['#ffffff', {'r': 0xff, 'g':0xff, 'b':0xff}],
            \['#010203', {'r': 0x01, 'g':0x02, 'b':0x03}],
            \]

function! s:t_hex_fromRgb_test()
    for test in s:tests
        let correct_hex = test[0]
        let correct_rgb = test[1]
        let test_hex = capesky#t_hex#fromRgb(correct_rgb)
        let result = (correct_hex == test_hex) ? 'OK' : 'FAIL'
        echom printf("t_hex#fromRgb(%s) -> %3s == %3s ? %s", capesky#t_rgb#toStr(correct_rgb), correct_hex, test_hex, result)
    endfor
    echom
endfunction
call s:t_hex_fromRgb_test()

function! s:t_hex_toRgb_test()
    for test in s:tests
        let correct_hex = test[0]
        let correct_rgb = test[1]
        let test_rgb = capesky#t_hex#toRgb(correct_hex)
        let pass = (test_rgb.r == correct_rgb.r) && (test_rgb.g == correct_rgb.g) && (test_rgb.b == correct_rgb.b)
        let result = (pass) ? 'OK' : 'FAIL'
        echom printf("t_hex#toRgb('%s') -> (%s) == (%s) ? %s", correct_hex, capesky#t_rgb#toStr(correct_rgb), capesky#t_rgb#toStr(test_rgb), result)
    endfor
    echom
endfunction
call s:t_hex_toRgb_test()
