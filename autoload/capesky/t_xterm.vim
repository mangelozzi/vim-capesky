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
    let diff_r = abs(a:rgb1.r - a:rgb2.r)
    let diff_g = abs(a:rgb1.g - a:rgb2.g)
    let diff_b = abs(a:rgb1.b - a:rgb2.b)
    let is_gray_diff = (a:rgb1.r == a:rgb1.b) && (a:rgb1.b == a:rgb1.g) && (a:rgb2.r == a:rgb2.b) && (a:rgb2.b == a:rgb2.g)
    if !is_gray_diff
        " The human eye is most sensitive to green light, less to red and least to blue.
        " In the ratio of about 50 / 33 / 16
        return 16*diff_r + 33*diff_g + 50*diff_b
    else
        " Slightly favour pure gray colors if is gray
        return 32*diff_r + 32*diff_g + 32*diff_b
    endif
endfunction
let s:max_error = s:colorDiff({'r':0, 'g':0, 'b':0}, {'r':0xff, 'g':0xff, 'b':0xff})

" Converts RGB object -> xterm 255 color number
"     Does not use colors 0-15 because they are none standard (customised)
"     This function is too slow to use to be used to convert all colours on
"     the fly, but used to check capesky#t_xterm#fromRgb (faster version same
"     output)
function! capesky#t_xterm#fromRgbSlow(rgb)
    let best = s:max_error
    let e = 0 " Init for scope
    for i in range(16, 255)
        let rgb_check = s:c[i]
        let e = s:colorDiff(a:rgb, rgb_check)
        if e <= best
            let best = e
            let n = i
        endif
    endfor
    return n
endfunction

function! capesky#t_xterm#toRgb(n)
    let rgb = s:c[a:n]
    return rgb
endfunction

" Colors step at these points
" let s:steps =    [ 0,  95, 135, 175, 215, 255]
" Thresholds (dec) [   48, 115, 155, 195, 235  ]
" Thresholds (hex) [   30,  73,  9b,  c3,  eb  ]
function! s:getClosestColorComponent(n)
    if a:n >= 0x73
        return (a:n - 35) / 0x28
    elseif a:n < 0x30
        return 0
    else
        return 1
    endif
endfunction
function! s:getClosestXtermColor16To231(rgb)
    let r = s:getClosestColorComponent(a:rgb.r)
    let g = s:getClosestColorComponent(a:rgb.g)
    let b = s:getClosestColorComponent(a:rgb.b)
    return 16 + 0x24*r + 6*g + b
endfunction

function! s:getClosestXtermGray232To255(rgb)
    let l = a:rgb.r
    if l <= 0x03
        return 16 " black
    elseif l >= 0xf7
        return 231 "white
    elseif l>= 0xe9
        return 255 "darkest gray
    else
        " Some gray inbetween
        return (l - 3)/10 + 232
    endif
endfunction

" Fast implentation of of getting xterm colour from RGB object
function! capesky#t_xterm#fromRgb(rgb)
    let color_n = s:getClosestXtermColor16To231(a:rgb)
    let gray_n  = s:getClosestXtermGray232To255(a:rgb)
    let color_rgb = s:c[color_n]
    let gray_rgb  = s:c[gray_n]
    let n = (s:colorDiff(a:rgb, color_rgb) < s:colorDiff(a:rgb, gray_rgb)) ? color_n : gray_n
    return n
endfunction
