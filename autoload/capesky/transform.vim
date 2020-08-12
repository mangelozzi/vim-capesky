function! capesky#transform#clamp(number, min, max)
    if a:number < a:min
        return a:min
    elseif a:number > a:max
        return a:max
    else
        return a:number
    endif
endfunction

function! capesky#transform#byteclamp(number)
    " floor works better then round for reverse transforms
    let n = (type(a:number) == v:t_float) ? float2nr(round(a:number)) : a:number
    return capesky#transform#clamp(n, 0, 255)
endfunction

function! capesky#transform#hue(hsl, hue)
    " hue from -50 to +50
    if a:hue == 0
        return a:hsl
    endif
    let a:hsl.h = (a:hsl.h + a:hue/100.0)
    if a:hsl.h > 1
        let a:hsl.h -=1
    elseif a:hsl.h < 0
        let a:hsl.h +=1
    endif
    return a:hsl
endfunction

function! capesky#transform#saturation(hsl, saturation)
    " saturation from -50 to +50
    if a:saturation == 0
        return a:hsl
    endif
    let a:hsl.s = capesky#transform#clamp(a:hsl.s + a:saturation/100.0, 0.0, 1.0)
    return a:hsl
endfunction

function! capesky#transform#lightness(hsl, lightness)
    " lightness from -50 to +50
    if a:lightness == 0
        return a:hsl
    endif
    let a:hsl.l = capesky#transform#clamp(a:hsl.l + a:lightness/100.0, 0.0, 1.0)
    return a:hsl
endfunction

function! capesky#transform#contrast(rgb, contrast)
    " contrast from -50 to +50
    let f = (80.0 + a:contrast) / (80.0 - a:contrast)
    let x = {}
    let x.r = capesky#transform#byteclamp(f * (a:rgb.r - 128) + 128)
    let x.g = capesky#transform#byteclamp(f * (a:rgb.g - 128) + 128)
    let x.b = capesky#transform#byteclamp(f * (a:rgb.b - 128) + 128)
    return x
endfunction

function! capesky#transform#all(hex, hue, saturation, lightness, contrast)
    " settings from -50 to +50
    let rgb = capesky#convert#hex2rgb(a:hex)
    let rgb = capesky#transform#contrast(rgb, a:contrast)
    let hsl = capesky#convert#rgb2hsl(rgb)
    let hsl = capesky#transform#hue(hsl, a:hue)
    let hsl = capesky#transform#saturation(hsl, a:saturation)
    let hsl = capesky#transform#lightness(hsl, a:lightness)
    let rgb = capesky#convert#hsl2rgb(hsl)
    let result = capesky#convert#rgb2hex(rgb)
    return result
endfunction
