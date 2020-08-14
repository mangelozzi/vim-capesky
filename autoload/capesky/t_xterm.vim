" Color chart colrs
" https://jonasjacek.github.io/colors/

function! s:getXterm2RgbDict()
    let c = {}
    let steps = [0, 95, 135, 175, 215, 255]
    let i = 16
    for r in steps
        for g in steps
            for b in steps
                let c[i] = {'r':r, 'g':g, 'b':b}
                " echom printf("%3i - %3d %3d %3d", i, r, g, b)
                let i += 1
            endfor
        endfor
    endfor
    for i in range(232, 255)
        let l =  8 + (i - 232) * 10
        let c[i] = {'r':l, 'g':l, 'b':l}
        " echom printf("%3i - %3d %3d %3d", i, l,l, l)
    endfor
    return c
endfunction
let s:c = s:getXterm2RgbDict()

" Given two RGB ojects, gives the difference between the two
function! s:colorDiff(rgb1, rgb2)
    " The human eye is most sensitive to green light, less to red and least to blue.
    let diff_r = 33 * abs(a:rgb1.r - a:rgb2.r)
    let diff_g = 50 * abs(a:rgb1.g - a:rgb2.g)
    let diff_b = 16 * abs(a:rgb1.b - a:rgb2.b)
    let diff = diff_r + diff_g + diff_b
    return diff
endfunction

" Given two RGB ojects, and one is gray, gives the manhattan difference.
function! s:grayDiff(rgb1, rgb2)
    let diff_r = abs(a:rgb1.r - a:rgb2.r)
    let diff_g = abs(a:rgb1.g - a:rgb2.g)
    let diff_b = abs(a:rgb1.b - a:rgb2.b)
    let diff = diff_r + diff_g + diff_b
    return diff
endfunction
let s:rgb_black = capesky#t_hex#toRgb('#000000')
let s:rgb_white = capesky#t_hex#toRgb('#ffffff')
let s:max_error = s:colorDiff(s:rgb_black, s:rgb_white)

" Converts RGB object -> xterm 255 color number
"     Does not use colors 0-15 because they are none standard (customised)
function! capesky#t_xterm#fromRgb(rgb)
    let is_gray = (a:rgb.r == a:rgb.b) && (a:rgb.b == a:rgb.g)
    let best = s:max_error
    let e = 0 " Init for scope
    for i in range(16, 255)
        let rgb_check = s:c[i]
        if is_gray
            let e = s:grayDiff(a:rgb, rgb_check)
        else
            let e = s:colorDiff(a:rgb, rgb_check)
        endif
        if e <= best
            let best = e
            let n = i
            if e <= 8
                " I think won't find a closer match
                return n
            endif
        endif
    endfor
    return n
endfunction

function! capesky#t_xterm#toRgb(n)
    let rgb = s:c[a:n]
    return rgb
endfunction

