" Convert hex code string to RGB object
"    Assumes hex is in html format, e.g. '#123456'
function! capesky#t_hex#toRgb(hex)
    let rgb = {}
    let rgb.r = str2nr(a:hex[1:2], 16)
    let rgb.g = str2nr(a:hex[3:4], 16)
    let rgb.b = str2nr(a:hex[5:6], 16)
    return rgb
endfunction

" Convert RGB object to hex code string
"    Assumes rgb objects has r/g/b integer attributes between 0 and 255.
function! capesky#t_hex#fromRgb(rgb)
    return printf('#%02x%02x%02x', a:rgb.r, a:rgb.g, a:rgb.b)
endfunction

