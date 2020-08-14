" Based on Garry Tan javascript algorithm that was posted on his now archived blog.

" Helper function for hsl -> rgb conversion
function! s:hueToRgb(p, q, t)
    let t = a:t
    let t += t < 0 ? 1 : 0
    let t -= t > 1 ? 1 : 0
    if t < 1.0/6
        return a:p + (a:q - a:p) * 6 * t
    elseif t < 0.5
        return a:q
    elseif t < 2.0/3
        return a:p + (a:q - a:p) * (2.0/3 - t) * 6
    endif
    return a:p
endfunction

" Converts an HSL color value to RGB. Conversion formula
"    adapted from http://en.wikipedia.org/wiki/HSL_color_space.
"    Assumes h, s, and l are contained in the set [0, 1] and
"    returns r, g, and b in the set [0, 255].
function! capesky#t_hsl#toRgb(hsl)
    if (a:hsl.s == 0)
        let a:hsl.r = float2nr(a:hsl.l * 255)
        let a:hsl.g = float2nr(a:hsl.l * 255)
        let a:hsl.b = float2nr(a:hsl.l * 255)
    else
        let q = a:hsl.l < 0.5 ? a:hsl.l * (1 + a:hsl.s) : a:hsl.l + a:hsl.s - a:hsl.l * a:hsl.s
        let p = 2 * a:hsl.l - q
        let a:hsl.r = float2nr(s:hueToRgb(p, q, a:hsl.h + 1.0/3) * 255)
        let a:hsl.g = float2nr(s:hueToRgb(p, q, a:hsl.h) * 255)
        let a:hsl.b = float2nr(s:hueToRgb(p, q, a:hsl.h - 1.0/3) * 255)
    endif
    return a:hsl
endfunction

" Converts an RGB color value to HSL. Conversion formula
"    adapted from http://en.wikipedia.org/wiki/HSL_color_space.
"    Assumes r, g, and b are contained in the set [0, 255] and
"    returns h, s, and l in the set [0, 1].
function! capesky#t_hsl#fromRgb(rgb)
    let x={}
    let x.r = a:rgb.r / 255.0
    let x.g = a:rgb.g / 255.0
    let x.b = a:rgb.b / 255.0
    let max = max(a:rgb) / 255.0
    let min = min(a:rgb) / 255.0
    let d = max - min
    let x.l = (max + min) / 2.0

    if (d == 0)
        " achromatic
        let x.h = 0.0
        let x.s = 0.0
    else
        if (max == x.r)
            let x.h = (x.g - x.b) / d + (x.g < x.b ? 6 : 0)
        elseif (max == x.g)
            let x.h = (x.b - x.r) / d + 2
        elseif (max == x.b)
            let x.h = (x.r - x.g) / d + 4
        endif
        let x.h /= 6.0
        let x.s = x.l > 0.5 ? d / (2.0 - max - min) : d / (max + min)
    endif
    return x
endfunction
