function! capesky#utils#clamp(number, min, max)
    if a:number < a:min
        return a:min
    elseif a:number > a:max
        return a:max
    else
        return a:number
    endif
endfunction

function! capesky#utils#byteclamp(number)
    " floor works better than round for transforming back to the original again
    let n = (type(a:number) == v:t_float) ? float2nr(round(a:number)) : a:number
    return capesky#utils#clamp(n, 0, 255)
endfunction

function! capesky#utils#hexToXterm(hex)
    let rgb = capesky#t_hex#toRgb(a:hex)
    let xterm = capesky#t_xterm#fromRgb(rgb)
    return xterm
endfunction
